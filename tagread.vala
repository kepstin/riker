/*
 * Riker - a MusicBrainz-enhanced audio player
 * Copyright © 2011 Calvin Walton
 *
 * This program is free software; you can redistribute it and/or
 * modify it under the terms of version 2 of the GNU General Public
 * License as published by the Free Software Foundation.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 */

namespace Riker {

class TagRead {

	public static int main(string[] args) {
		Gst.init(ref args);

#if ENABLE_UNINSTALLED
		stderr.printf("This is an UNINSTALLED build. Do not install it.\n");
		stderr.printf("Using files from source directory: %s\n", Config.BUILD_SRCDIR);
#endif

		var store = new Store();
		
		try {
			store.open();
		} catch (StoreError e) {
			if (e is StoreError.CORRUPT_DB) {
				stderr.printf("%s\n", e.message);
				stderr.printf("To resolve this, try deleting the database file so it can be re-created.\n");
			} else {
				stderr.printf("%s\n", e.message);
			}
			return 1;
		}
		
		if (args.length < 2) {
			stderr.printf("Usage: %s file:///path/to/file\n", args[0]);
			return 1;
		}
		
		GLib.File filearg = GLib.File.new_for_commandline_arg(args[1]);
		var uri = filearg.get_uri();
		
		// This is the information that will be stored per-file.
		string? recording_mbid = null;
		string? release_mbid = null;
		uint track_position = 0;
		uint medium_position = 0;
		string? codec = null;
		uint bitrate = 0;
		uint duration = 0;
		
		var pipe = new Gst.Pipeline("pipeline");
		
		dynamic Gst.Element dec = Gst.ElementFactory.make("uridecodebin", null);
		dec.uri = uri;
		pipe.add(dec);
		
		Gst.Element sink = Gst.ElementFactory.make("fakesink", null);
		pipe.add(sink);
		
		dec.pad_added.connect((pad) => {
			var sinkpad = sink.get_static_pad("sink");
			if (!sinkpad.is_linked()) {
				if (pad.link(sinkpad) != Gst.PadLinkReturn.OK) {
					error("Failed to link pads!");
				}
			}
		});
		
		pipe.set_state(Gst.State.PAUSED);
		
		while (true) {
			var msg = pipe.get_bus().timed_pop_filtered(Gst.CLOCK_TIME_NONE, Gst.MessageType.ASYNC_DONE | Gst.MessageType.TAG | Gst.MessageType.ERROR);

			if (msg.type != Gst.MessageType.TAG) {
				break;
			}

			Gst.TagList tags;
			msg.parse_tag(out tags);

			if (tags.get_tag_size(Gst.TAG_MUSICBRAINZ_TRACKID) > 0)
				tags.get_string(Gst.TAG_MUSICBRAINZ_TRACKID, out recording_mbid);

			if (tags.get_tag_size(Gst.TAG_MUSICBRAINZ_ALBUMID) > 0)
				tags.get_string(Gst.TAG_MUSICBRAINZ_ALBUMID, out release_mbid);

			if (tags.get_tag_size(Gst.TAG_TRACK_NUMBER) > 0)
				tags.get_uint(Gst.TAG_TRACK_NUMBER, out track_position);

			if (tags.get_tag_size(Gst.TAG_ALBUM_VOLUME_NUMBER) > 0)
				tags.get_uint(Gst.TAG_ALBUM_VOLUME_NUMBER, out medium_position);

			if (tags.get_tag_size(Gst.TAG_AUDIO_CODEC) > 0)
				tags.get_string(Gst.TAG_AUDIO_CODEC, out codec);

			if (tags.get_tag_size(Gst.TAG_BITRATE) > 0)
				tags.get_uint(Gst.TAG_BITRATE, out bitrate);
		}
		
		var query = new Gst.Query.duration(Gst.Format.TIME);
		var res = pipe.query(query);
		if (res) {
			int64 duration_ns;
			query.parse_duration(null, out duration_ns);
			duration = (uint) (duration_ns / 1000000);
		}
		
		/*File file = new File.from_data(recording_mbid, release_mbid, track_position, medium_position, codec, bitrate, duration);*/
		
		print("recording_mbid: %s\n", recording_mbid);
		print("release_mbid: %s\n", release_mbid);
		print("track_position: %u\n", track_position);
		print("medium_position: %u\n", medium_position);
		print("codec: %s\n", codec);
		print("bitrate: %u\n", bitrate);
		print("duration: %u\n", duration);
		
		pipe.set_state(Gst.State.NULL);
		
		print("Performing a musicbrainz query...\n");
		
		Musicbrainz.Query mb4_query = new Musicbrainz.Query("Riker/0.1 ( http://www.kepstin.ca/projects/riker )");
		Musicbrainz.Metadata m = mb4_query.query("release", release_mbid, null, inc: "media recordings");
		
		Musicbrainz.Release r = m.release;
		if (r != null) {
			print("Release title: %s\n", r.title);
		}
		
		return 0;
	}
}

}

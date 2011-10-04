namespace Riker {

class TagRead : GLib.Object {

	public static int main(string[] args) {
		Gst.init(ref args);
		
		var store = new Store();
		store.open();
		
		if (args.length < 2) {
			warning("Usage: %s file:///path/to/file", args[0]);
			return 1;
		}
		
		if (!Gst.uri_is_valid(args[1])) {
			warning("%s is not a valid URI.", args[1]);
			return 1;
		}
		
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
		dec.uri = args[1];
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
		
		print("recording_mbid: %s\n", recording_mbid);
		print("release_mbid: %s\n", release_mbid);
		print("track_position: %u\n", track_position);
		print("medium_position: %u\n", medium_position);
		print("codec: %s\n", codec);
		print("bitrate: %u\n", bitrate);
		print("duration: %u\n", duration);
		
		pipe.set_state(Gst.State.NULL);
		
		return 0;
	}
}

}

namespace Riker {

class TagRead : GLib.Object {

	public static int main(string[] args) {
		Gst.init(ref args);
		
		if (args.length < 2) {
			warning("Usage: %s file:///path/to/file", args[0]);
			return 1;
		}
		
		if (!Gst.uri_is_valid(args[1])) {
			warning("%s is not a valid URI.", args[1]);
			return 1;
		}
		
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

			var num = tags.get_tag_size(Gst.TAG_MUSICBRAINZ_TRACKID);
			for (uint i = 0; i < num; ++i) {
				string val;
				if (tags.get_string_index(Gst.TAG_MUSICBRAINZ_TRACKID, i, out val)) {
					print("\tRecording MBID: %s\n", val);
				}
			}
			
			num = tags.get_tag_size(Gst.TAG_MUSICBRAINZ_ALBUMID);
			for (uint i = 0; i < num; ++i) {
				string val;
				if (tags.get_string_index(Gst.TAG_MUSICBRAINZ_ALBUMID, i, out val)) {
					print("\tRelease MBID: %s\n", val);
				}
			}
			
			tags.foreach((_, tag) => {
				print("\t%s: ", tag);
				
				num = tags.get_tag_size(tag);
				
				for (uint i = 0; i < num; ++i) {
					var val = tags.get_value_index(tag, i);
					var type = val.type();
					if (type == typeof (string)) {
						print("%s", val.get_string());
					} else if (type == typeof (uint)) {
						print("%u", val.get_uint());
					} else if (type == typeof (double)) {
						print("%g", val.get_double());
					}
				}
				
				print("\n");
			});
		}
		
		pipe.set_state(Gst.State.NULL);
		
		return 0;
	}
}

}

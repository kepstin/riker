#include <gst/gst.h>

static void print_one_tag(const GstTagList *list, const gchar *tag, gpointer user_data)
{
	int i, num;
	
	num = gst_tag_list_get_tag_size(list, tag);
	for (i = 0; i < num; ++i) {
		const GValue *val;
		
		/*
		 * Note: when looking for specific tags, use the g_tag_list_get_xyz() API,
		 * we only use the GValue approach here because it is more generic.
		 */
		val = gst_tag_list_get_value_index(list, tag, i);
		g_print("\t%20s : ", tag);
		if (G_VALUE_HOLDS_STRING(val)) {
			g_print("%s", g_value_get_string(val));
		} else if (G_VALUE_HOLDS_UINT(val)) {
			g_print("%u", g_value_get_uint(val));
		} else if (G_VALUE_HOLDS_DOUBLE(val)) {
			g_print("%g", g_value_get_double(val));
		} else if (G_VALUE_HOLDS_BOOLEAN(val)) {
			g_print("%s", g_value_get_boolean(val) ? "true" : "false");
		} else {
			g_print("tag of type '%s'\n", G_VALUE_TYPE_NAME(val));
		}
		g_print("\n");
	}
}

static void on_new_pad(GstElement *dec, GstPad *pad, GstElement *fakesink)
{
	GstPad *sinkpad;
	
	sinkpad = gst_element_get_static_pad(fakesink, "sink");
	if (!gst_pad_is_linked(sinkpad)) {
		if (gst_pad_link(pad, sinkpad) != GST_PAD_LINK_OK) {
			g_error("Failed to link pads!");
		}
	}
	gst_object_unref(sinkpad);
}

int main(int argc, char *argv[])
{
	GstElement *pipe, *dec, *sink;
	GstMessage *msg;
	
	gst_init(&argc, &argv);
	
	if (argc < 2 || !gst_uri_is_valid(argv[1])) {
		g_error("Usage: %s file:///path/to/file", argv[0]);
	}
	
	pipe = gst_pipeline_new("pipeline");
	
	dec = gst_element_factory_make("uridecodebin", NULL);
	g_object_set(dec, "uri", argv[1], NULL);
	gst_bin_add(GST_BIN(pipe), dec);
	
	g_signal_connect(dec, "pad-added", G_CALLBACK(on_new_pad), sink);
	
	gst_element_set_state(pipe, GST_STATE_PAUSED);
	
	while (TRUE) {
		GstTagList *tags = NULL;
		
		msg = gst_bus_timed_pop_filtered(GST_ELEMENT_BUS(pipe),
			GST_CLOCK_TIME_NONE,
			GST_MESSAGE_ASYNC_DONE | GST_MESSAGE_TAG | GST_MESSAGE_ERROR);
		
		if (GST_MESSAGE_TYPE(msg) != GST_MESSAGE_TAG)
			break;
		
		gst_message_parse_tag(msg, &tags);
		
		g_print("Got tags from element %s:\n", GST_OBJECT_NAME(msg->src));
		gst_tag_list_foreach(tags, print_one_tag, NULL);
		g_print("\n");
		gst_tag_list_free(tags);
		
		gst_message_unref(msg);
	}
	
	if (GST_MESSAGE_TYPE(msg) == GST_MESSAGE_ERROR)
		g_error("Got error");
	
	gst_message_unref(msg);
	gst_element_set_state(pipe, GST_STATE_NULL);
	gst_object_unref(pipe);
	return 0;
}

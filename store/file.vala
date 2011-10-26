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

public class File {
	public string? recording_mbid { get; set; }
	public string? release_mbid { get; set; }
	public uint track_position { get; set; }
	public uint medium_position { get; set; }
	public string? codec { get; set; }
	public uint bitrate { get; set; }
	public uint duration { get; set; }
	
	public File.from_data(string recording_mbid,
	                      string release_mbid,
	                      uint track_position,
	                      uint medium_position,
	                      string codec,
	                      uint bitrate,
	                      uint duration) {
		this.recording_mbid = recording_mbid;
		this.release_mbid = release_mbid;
		this.track_position = track_position;
		this.medium_position = medium_position;
		this.codec = codec;
		this.bitrate = bitrate;
		this.duration = duration;
	}
}

}

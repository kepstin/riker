void main (string[] args) {

    string disc_id;

    if (args.length == 1) {
        disc_id = "tNSQ3K59B8ZkSb19P__Jet6B.sk-";
    }
    else if (args.length == 2) {
        disc_id = args[1];
    } else {
        return;
    }

    var query = new Musicbrainz.Query("cdlookupexample-1.0");
    var metadata = query.query("discid", disc_id, null);

    if (metadata.disc.release_list == null) return;

    var release_list = metadata.disc.release_list;
    stdout.printf(@"Found $(release_list.size) release(s)\n");

    foreach (var release in release_list) {

        var md2 = query.query("release", release.id, "", inc:
            "artists labels recordings release-groups url-rels discids artist-credits");
        var media_list = md2.release.media_matching_disc_id(disc_id);

        stdout.printf("Found %d media item(s)\n", media_list.size);
        foreach (var medium in media_list) {
            stdout.printf(@"Found media: '$(medium.title)' - " + 
                          @"position: $(medium.position), format: $(medium.format)\n");
            var track_list = medium.track_list;
            if (track_list == null) continue;
            foreach (var track in track_list) {
                var artist = track.recording.artist_credit.name_credit_list[0].artist.name;
                stdout.printf(@"$(track.position) | $(artist) - " + 
                              @"'$(track.recording.title)' ($(track.recording.length))\n");
            }
        }
    }
}

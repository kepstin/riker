public MediumList media_matching_disc_id (string disc_id) {
    return new MediumList.wrap (((Mb4.Release*)instance) -> media_matching_disc_id (disc_id), false);
}

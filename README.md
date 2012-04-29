Riker is the Number One music player for MusicBrainz users.
===========================================================

Or, at least it will be. Right now it's not done. But you can help test it or
develop it! Since you can see this, I'll assume you already have a git
checkout. Or maybe you're reading this on a website, in which case you should
go get a git checkout. Go ahead, I'll wait for you to come back.

Anyways, before you can build Riker you'll need a few things. First is
libmusicbrainz-4. Some Linux distributions are starting to pick this up, but
not all have it yet. If you're not sure, go to
http://musicbrainz.org/doc/libmusicbrainz and install it manually.

Next you'll need the Vala compiler, valac. Version 0.14 should do it, this
should be in your distribution packages. Also sqlite 3, glib, and gstreamer.
Don't forget their associated development packages, if your Linux distribution
has a habit of inconveniencing people who like to actually *use* their
computers.

Now for a more tricky bit - You will need a build of libgda from git master in
order to get the new Vala object model bindings. (Unless you're from the
future -- in which case you can just grab libgda-5.2 and use that.)

Clone the git repository at git://git.gnome.org/libga, and run these commands:

    NOCONFIGURE=1 ./autogen.sh
    ./configure --enable-vala --enable-vala-extensions
    make
    make install # (or use checkinstall, or whatever)

Still with me? Now we're ready to go. cd into the riker source directory, and
run these commands:

    ./autogen.sh
    ./configure
    make

And you'll have it built. Or maybe not; in which case you have some errors to
help me fix.

There are two test applications that are currently built. First: tagread
To run it:

    ./tagread ~/Music/your-fav-song.mp3

It'll print a bunch of info about setting up the database, then read the 
tags from the file. Then it does a MusicBrainz webservice lookup, and prints
out the information. Then you realize that it didn't actually do anything with
the database, so why did it bother setting it up? I'll get to that later.

The second application might be more interesting: add_artist
To run it:

    ./add_artist <artist mbid>

(Or if you don't remember any artist MBIDs offhand, I included a default:)

    ./add_artist

It'll go and set up the database (if you've already run tagread it'll be faster
the second time, since the database schema is already set up), then look up an
artist. If the artist is not in the db, it'll query the MusicBrainz webservice
for info and add the artist to the db.
Try running it twice on the same artist.

And... that's it. It will be a music player eventually, I promise.
If you help, we can get there faster :)

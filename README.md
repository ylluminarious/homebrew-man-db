# `man-db` and `libpipeline` for OS X

`man-db` is the man page system for Linux. It is more featureful than OS X's built-in `man` command (which is derived from an old version of BSD). It is quite useful for developers and system administrators and some useful software plugins rely on Linux's `man` behavior, which has not been available on OS X hitherto.

`man-db` depends on a library called `libpipeline` which is also included in this repository. Unfortunately, both of these programs expect to be on a Linux system rather exclusively. So, some patches and extra compilation options are necessary in order to get these programs to work right.

[I tried](https://github.com/Homebrew/homebrew-core/pull/25376) to get these packages into the main package repository at one point, but they rejected my changes. Unfortunately, homebrew-core seems to have a pretty strict policy on adhering to the test suite and will not allow new programs which rely on patches (even though there are already ~300 packages in Homebrew which use patches at the time of this writing). One would think that Homebrew would be a little more lenient since it actually has the smallest package selection on OS X, when compared to [Macports](https://www.macports.org/ports.php) or [Fink](http://pdb.finkproject.org/pdb/index.php?phpLang=en). These other package managers have *several times* more packages in the core repositories than Homebrew. But the Homebrew maintainers seem to be pretty strict nowadays, which leads to lots of "taps" like this (which are like PPA's on Ubuntu).

## Installation

Since these packages are not core Homebrew packages (see above), you must first install this repository as a "tap:"

```
brew tap ylluminarious/man-db
```

To install both of these packages, you can simply run:

```
brew install man-db
```

And both packages will be installed to your system since `man-db` is dependent on `libpipeline`.

To install just `libpipeline`:

```
brew install libpipeline
```

Everything else should be fairly straightforward. You can consult with the documentation of each respective package.

## License

Umm... hmm... both of these programs that I'm providing are licensed under GPLv3... which is a pretty strict "copyleft" license. But my programs are not actually related to the programs which are downloaded and installed from my programs. Hmm... I hope the FSF doesn't sue me for this... well, I guess I'll release these "formulas" i.e. the files under the `Formula` directory of this repository under the [BSD-3 license,](https://opensource.org/licenses/BSD-3-Clause) which is effectively like public domain while I retain a copyright. I'm not sure if that makes 100% sense in legalese... but darn it, I'm a developer, Jim, not a lawyer.

If I've flubbed up in some way with the license, file a ticket, I guess. Software licenses are such silly things anyway.
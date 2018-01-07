mudkipme/mediawiki
==================

This repository is a fork of [MediaWiki](https://www.mediawiki.org) running on [52Poké Wiki](https://wiki.52poke.com).

At 52Poké Wiki, we made some minor changes to core MediaWiki for certain needs, and these are absolutely cannot be done via extensions and not suitable for most other MediaWiki installations. Please [compare](https://github.com/wikimedia/mediawiki/compare/1.35.0...mudkipme:52w) for details.

These changes should be undone whenever available hooks are introduced in future versions of MediaWiki, and should be merged when core MediaWiki is upgraded on 52Poké Wiki.

Currently the MediaWiki [version](https://wiki.52poke.com/wiki/Special:%E7%89%88%E6%9C%AC) running on 52Poké Wiki is `1.35.0`.

## Changes

* __Allowing duplicate interwikis:__ Some articles on 52Poké Wiki correspond to multiple articles on other [Encyclopædiæ Pokémonis](http://www.encyclopaediae-pokemonis.org/) sites. So duplicate interwikis are sometime needed.
* __Add images to parser when using `filepath`:__ Some [gadgets](https://wiki.52poke.com/wiki/Help:%E6%97%B6%E9%97%B4%E5%B0%8F%E5%B7%A5%E5%85%B7) or templates on 52Poké Wiki use `filepath` to retrieve images to be displayed based on certain conditions. By adding these images to parser, it can make sure relevant special pages be updated.

SHELL := bash

deps:
	test -f .gitmodules && cat .gitmodules | sed -e 's#\/p\/#\/#g' > .gitmodules.wpd
	cp .gitmodules.wpd .gitmodules
	git add .gitmodules && git commit -m wpd
	git rm -rf --cached skins/Vector
	git submodule update --init --recursive
	test -d extensions/NewSignupPage || git submodule add https://git.wikimedia.org/git/mediawiki/extensions/NewSignupPage extensions/NewSignupPage
	test -d extensions/StringFunctionsEscaped || git submodule add https://git.wikimedia.org/git/mediawiki/extensions/StringFunctionsEscaped extensions/StringFunctionsEscaped
	test -d extensions/LookupUser || git submodule add https://git.wikimedia.org/git/mediawiki/extensions/LookupUser extensions/LookupUser
	test -d extensions/SemanticInternalObjects || git submodule add https://git.wikimedia.org/git/mediawiki/extensions/SemanticInternalObjects extensions/SemanticInternalObjects
	test -d extensions/SocialProfile || git submodule add https://git.wikimedia.org/git/mediawiki/extensions/SocialProfile extensions/SocialProfile
	test -d extensions/AdminLinks || git submodule add https://git.wikimedia.org/git/mediawiki/extensions/AdminLinks extensions/AdminLinks
	test -d extensions/WebPlatformSearchAutocomplete || git submodule add https://git.wikimedia.org/git/mediawiki/extensions/WebPlatformSearchAutocomplete extensions/WebPlatformSearchAutocomplete
	test -d extensions/ConfirmAccount || git submodule add https://git.wikimedia.org/git/mediawiki/extensions/ConfirmAccount extensions/ConfirmAccount
	test -d extensions/WebPlatformMediaWikiExtensionBundle || git submodule add https://github.com/webplatform/mediawiki.git extensions/WebPlatformMediaWikiExtensionBundle
	test -d extensions/AccountRelier || git submodule add https://github.com/webplatform/mediawiki-fxa-sso.git extensions/AccountRelier
	patch -s -p1 --directory extensions/SocialProfile/ < patches/extensions/SocialProfile/changeset-disable-profile-avatar.patch
	patch -s -p1 --directory extensions/SocialProfile/ < patches/extensions/SocialProfile/forbid-edit-profile-if-email-not-confirmed.patch
	patch -s -p1 --directory extensions/WebPlatformSearchAutocomplete/ < patches/extensions/WebPlatformSearchAutocomplete/fix-broken-autocomplete.patch

.PHONY: deps

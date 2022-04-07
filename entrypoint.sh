#!/bin/bash

## Backup the original .bashrc file
if ! test -f "${HOME}/.bashrc_orig"; then
	cp "${HOME}/.bashrc" "${HOME}/.bashrc_orig"
fi

## Update files 
cp "${HOME}/.bashrc_orig" "${HOME}/.bashrc"
cat >> "${HOME}/.bashrc" <<-EOF
	#
	# Tools setup for debian packaging
	DEBEMAIL=${DP_EMAIL}
	DEBFULLNAME=${DP_FULLNAME}
	export DEBEMAIL DEBFULLNAME
	git config --global user.email ${DP_EMAIL}
	git config --global user.name ${DP_FULLNAME}
EOF

if ! test -f "${HOME}/.devscripts"; then
	cat > "/root/.devscripts" <<-EOF
		DEBUILD_DPKG_BUILDPACKAGE_OPTS="-i -I -us -uc"
		DEBUILD_LINTIAN_OPTS="-i -I --show-overrides"
		DEBSIGN_KEYID=${DP_GPGKEYID}
EOF
fi

if ! test -f "${HOME}/.dput.cf"; then
	cat > "${HOME}/.dput.cf" <<- EOF
		[mentors]
		fqdn = mentors.debian.net
		incoming = /upload
		method = https
		allow_unsigned_uploads = 0
		progress_indicator = 2
		# Allow uploads for UNRELEASED packages
		allowed_distributions = .*
EOF
fi

## Upgrade operating system
apt-get update && apt-get upgrade --yes

## Run bash
/bin/bash

#!/usr/bin/env bash
#TODO: take arguments on which packages to apply
cmd="stow -vt ${HOME} bash git vim misc"
output="$(${cmd} 2>&1)"
# echo "${output}"
if [ "$output" ]; then
	echo "$?"
	conflicts="$(echo "${output}" | grep '^  \*' | awk 'NF>1{print$NF}')"
	echo -e "Conflicts detected in: ${conflicts}\nPlease fix before trying again."
	#TODO: display diff for each file in conflicts
else
	#TODO: Ask for confirmation before applying
	${cmd}
	# Reload the shell (i.e. invoke as a login shell)
	exec "$SHELL -l"
fi;



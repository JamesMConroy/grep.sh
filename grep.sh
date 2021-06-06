#!/usr/bin/env bash

main() {
	options=""
	entireLine=false
	while getopts "nlivx" arg
	do
		case "${arg}" in
			n) options+=n ;; # Line numbers
			l) options+=l ;; # only print file names
			i) shopt -s nocasematch ;; # ignore case
			v) options+=v ;; # invert match
			x) entireLine=true ;;  # match the entire line
			*) echo "Invalid Flag ${arg}"
		esac
	done
	shift $((OPTIND-1))

	regex="${1}"
	if $entireLine
	then
		regex="^${regex}$"
	fi
	shift 1

	if [[ ${#} -gt 1 ]]
	then
		options+=f
	fi

	for file in "${@}"
	do
		findMatch "${regex}" "${options}" "${file}"
	done
}

findMatch() {
	regex="${1}"
	options="${2}"
	file="${3}"

	number=0
	while read -r line
	do
		output=""
		(( number+=1))
		if ( [[ "${line}" =~ ${regex} ]] && [[ ! ${options} =~ v ]] ) || ( [[ ! "${line}" =~ ${regex} ]] && [[ ${options} =~ v ]] )
		then
			# Break early if we only want to know the files with lines that match
			if [[ ${options} =~ l ]]
			then
				echo "${file}"
				break
			fi
			if [[ ${options} =~ f ]]
			then
				output+="${file}:"
			fi
			if [[ ${options} =~ n ]]
			then

				output+="${number}:"
			fi
			output+="${line}"
			echo "${output}"
		fi
	done < "${file}"
}

main "${@}"

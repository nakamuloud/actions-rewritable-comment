#!/bin/sh
cd /app

if [ -z "$INPUT_OWNER" ]; then
  INPUT_OWNER=${GITHUB_REPOSITORY_OWNER}
fi

if [ -z "$INPUT_REPOSITORY" ]; then
  INPUT_REPOSITORY=${GITHUB_REPOSITORY#*/}
fi

if [ -z "$INPUT_ISSUE_NUMBER" ]; then
  INPUT_ISSUE_NUMBER=${GITHUB_REF%/*}
  INPUT_ISSUE_NUMBER=${ISSUE_NUMBER##*/}
fi

echo INPUT_OWNER: "${INPUT_OWNER}"
echo INPUT_REPOSITORY: "${INPUT_REPOSITORY}"
echo INPUT_ISSUE_NUMBER: "${INPUT_ISSUE_NUMBER}"
echo "<!-- INPUT_KEY : INPUT_COMMENT_ID --> : " "<!-- ${INPUT_KEY} : ${INPUT_COMMENT_ID} -->"
echo INPUT_VALUE: "${INPUT_VALUE}"

go run src/main.go -owner ${INPUT_OWNER} -repository ${INPUT_REPOSITORY} -commentId ${INPUT_COMMENT_ID} -issueNumber ${INPUT_ISSUE_NUMBER} -key ${INPUT_KEY:-default} -value ${INPUT_VALUE}

#!/bin/bash

OUTPUT_FILE="species_list.txt"

NELAT=4.561429351136301
NELNG=101.4370135694336
SWLAT=4.443282361077945
SWLNG=101.33046803896482

ICONIC_TAXA=Plantae
PER_PAGE=200

for cmd in curl jq; do
    if ! command -v "$cmd" >/dev/null 2>&1; then
        echo "Error: '$cmd' is required but not installed." >&2
        exit 1
    fi
done

TMP_FILE=$(mktemp)

#ページ数の算出
i=1
URL="https://api.inaturalist.org/v1/observations?iconic_taxa=${ICONIC_TAXA}&nelat=${NELAT}&nelng=${NELNG}&swlat=${SWLAT}&swlng=${SWLNG}&page=${i}&per_page=${PER_PAGE}&order=desc&order_by=created_at"
TOTAL_RESULTS=$(curl -X GET --header 'Accept: application/json' "$URL" | jq '.total_results')
MAX_PAGE_ID=$(echo "scale=0; ($TOTAL_RESULTS + $PER_PAGE - 1) / $PER_PAGE" | bc -l)

#観測データの取得と整形
for i in $(seq 1 $MAX_PAGE_ID); do
    URL="https://api.inaturalist.org/v1/observations?iconic_taxa=${ICONIC_TAXA}&nelat=${NELAT}&nelng=${NELNG}&swlat=${SWLAT}&swlng=${SWLNG}&page=${i}&per_page=${PER_PAGE}&order=desc&order_by=created_at"
    curl -X GET --header 'Accept: application/json' "${URL}" | jq '.results[].taxon.name' | sed -e 's@"@@g' >> ${TMP_FILE}
done
sort -u ${TMP_FILE} > ${OUTPUT_FILE}

rm $TMP_FILE

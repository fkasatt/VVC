#!/bin/bash

dir=$(git rev-parse --show-toplevel)
smile="$HOME/Scripts/opensmile"
tmp=$(mktemp)

mkdir -p "${dir}/features/"
mkdir -p "${dir}/features/VVC/"

cat "${dir}/list/VVC.list" | while read file
do
	input="${dir}/sound/VVC/nonBGM/${file/\.scene/.wav}"
	output="${dir}/features/VVC/${file/\.scene/.csv}"

	$smile/bin/SMILExtract -C $smile/config/is09-13/IS09_emotion.conf -I $input -O $tmp
	cat $tmp | tail -1 | sed '/^$/d' | sed 's/^unknown,//' | sed 's/..$//' | cat > $output
done

echo "pcm_RMSenergy_sma_max,pcm_RMSenergy_sma_min,pcm_RMSenergy_sma_range,pcm_RMSenergy_sma_maxPos,pcm_RMSenergy_sma_minPos,pcm_RMSenergy_sma_amean,pcm_RMSenergy_sma_linregc1,pcm_RMSenergy_sma_linregc2,pcm_RMSenergy_sma_linregerrQ,pcm_RMSenergy_sma_stddev,pcm_RMSenergy_sma_skewness,pcm_RMSenergy_sma_kurtosis,pcm_fftMag_mfcc_sma[1]_max,pcm_fftMag_mfcc_sma[1]_min,pcm_fftMag_mfcc_sma[1]_range,pcm_fftMag_mfcc_sma[1]_maxPos,pcm_fftMag_mfcc_sma[1]_minPos,pcm_fftMag_mfcc_sma[1]_amean,pcm_fftMag_mfcc_sma[1]_linregc1,pcm_fftMag_mfcc_sma[1]_linregc2,pcm_fftMag_mfcc_sma[1]_linregerrQ,pcm_fftMag_mfcc_sma[1]_stddev,pcm_fftMag_mfcc_sma[1]_skewness,pcm_fftMag_mfcc_sma[1]_kurtosis,pcm_fftMag_mfcc_sma[2]_max,pcm_fftMag_mfcc_sma[2]_min,pcm_fftMag_mfcc_sma[2]_range,pcm_fftMag_mfcc_sma[2]_maxPos,pcm_fftMag_mfcc_sma[2]_minPos,pcm_fftMag_mfcc_sma[2]_amean,pcm_fftMag_mfcc_sma[2]_linregc1,pcm_fftMag_mfcc_sma[2]_linregc2,pcm_fftMag_mfcc_sma[2]_linregerrQ,pcm_fftMag_mfcc_sma[2]_stddev,pcm_fftMag_mfcc_sma[2]_skewness,pcm_fftMag_mfcc_sma[2]_kurtosis,pcm_fftMag_mfcc_sma[3]_max,pcm_fftMag_mfcc_sma[3]_min,pcm_fftMag_mfcc_sma[3]_range,pcm_fftMag_mfcc_sma[3]_maxPos,pcm_fftMag_mfcc_sma[3]_minPos,pcm_fftMag_mfcc_sma[3]_amean,pcm_fftMag_mfcc_sma[3]_linregc1,pcm_fftMag_mfcc_sma[3]_linregc2,pcm_fftMag_mfcc_sma[3]_linregerrQ,pcm_fftMag_mfcc_sma[3]_stddev,pcm_fftMag_mfcc_sma[3]_skewness,pcm_fftMag_mfcc_sma[3]_kurtosis,pcm_fftMag_mfcc_sma[4]_max,pcm_fftMag_mfcc_sma[4]_min,pcm_fftMag_mfcc_sma[4]_range,pcm_fftMag_mfcc_sma[4]_maxPos,pcm_fftMag_mfcc_sma[4]_minPos,pcm_fftMag_mfcc_sma[4]_amean,pcm_fftMag_mfcc_sma[4]_linregc1,pcm_fftMag_mfcc_sma[4]_linregc2,pcm_fftMag_mfcc_sma[4]_linregerrQ,pcm_fftMag_mfcc_sma[4]_stddev,pcm_fftMag_mfcc_sma[4]_skewness,pcm_fftMag_mfcc_sma[4]_kurtosis,pcm_fftMag_mfcc_sma[5]_max,pcm_fftMag_mfcc_sma[5]_min,pcm_fftMag_mfcc_sma[5]_range,pcm_fftMag_mfcc_sma[5]_maxPos,pcm_fftMag_mfcc_sma[5]_minPos,pcm_fftMag_mfcc_sma[5]_amean,pcm_fftMag_mfcc_sma[5]_linregc1,pcm_fftMag_mfcc_sma[5]_linregc2,pcm_fftMag_mfcc_sma[5]_linregerrQ,pcm_fftMag_mfcc_sma[5]_stddev,pcm_fftMag_mfcc_sma[5]_skewness,pcm_fftMag_mfcc_sma[5]_kurtosis,pcm_fftMag_mfcc_sma[6]_max,pcm_fftMag_mfcc_sma[6]_min,pcm_fftMag_mfcc_sma[6]_range,pcm_fftMag_mfcc_sma[6]_maxPos,pcm_fftMag_mfcc_sma[6]_minPos,pcm_fftMag_mfcc_sma[6]_amean,pcm_fftMag_mfcc_sma[6]_linregc1,pcm_fftMag_mfcc_sma[6]_linregc2,pcm_fftMag_mfcc_sma[6]_linregerrQ,pcm_fftMag_mfcc_sma[6]_stddev,pcm_fftMag_mfcc_sma[6]_skewness,pcm_fftMag_mfcc_sma[6]_kurtosis,pcm_fftMag_mfcc_sma[7]_max,pcm_fftMag_mfcc_sma[7]_min,pcm_fftMag_mfcc_sma[7]_range,pcm_fftMag_mfcc_sma[7]_maxPos,pcm_fftMag_mfcc_sma[7]_minPos,pcm_fftMag_mfcc_sma[7]_amean,pcm_fftMag_mfcc_sma[7]_linregc1,pcm_fftMag_mfcc_sma[7]_linregc2,pcm_fftMag_mfcc_sma[7]_linregerrQ,pcm_fftMag_mfcc_sma[7]_stddev,pcm_fftMag_mfcc_sma[7]_skewness,pcm_fftMag_mfcc_sma[7]_kurtosis,pcm_fftMag_mfcc_sma[8]_max,pcm_fftMag_mfcc_sma[8]_min,pcm_fftMag_mfcc_sma[8]_range,pcm_fftMag_mfcc_sma[8]_maxPos,pcm_fftMag_mfcc_sma[8]_minPos,pcm_fftMag_mfcc_sma[8]_amean,pcm_fftMag_mfcc_sma[8]_linregc1,pcm_fftMag_mfcc_sma[8]_linregc2,pcm_fftMag_mfcc_sma[8]_linregerrQ,pcm_fftMag_mfcc_sma[8]_stddev,pcm_fftMag_mfcc_sma[8]_skewness,pcm_fftMag_mfcc_sma[8]_kurtosis,pcm_fftMag_mfcc_sma[9]_max,pcm_fftMag_mfcc_sma[9]_min,pcm_fftMag_mfcc_sma[9]_range,pcm_fftMag_mfcc_sma[9]_maxPos,pcm_fftMag_mfcc_sma[9]_minPos,pcm_fftMag_mfcc_sma[9]_amean,pcm_fftMag_mfcc_sma[9]_linregc1,pcm_fftMag_mfcc_sma[9]_linregc2,pcm_fftMag_mfcc_sma[9]_linregerrQ,pcm_fftMag_mfcc_sma[9]_stddev,pcm_fftMag_mfcc_sma[9]_skewness,pcm_fftMag_mfcc_sma[9]_kurtosis,pcm_fftMag_mfcc_sma[10]_max,pcm_fftMag_mfcc_sma[10]_min,pcm_fftMag_mfcc_sma[10]_range,pcm_fftMag_mfcc_sma[10]_maxPos,pcm_fftMag_mfcc_sma[10]_minPos,pcm_fftMag_mfcc_sma[10]_amean,pcm_fftMag_mfcc_sma[10]_linregc1,pcm_fftMag_mfcc_sma[10]_linregc2,pcm_fftMag_mfcc_sma[10]_linregerrQ,pcm_fftMag_mfcc_sma[10]_stddev,pcm_fftMag_mfcc_sma[10]_skewness,pcm_fftMag_mfcc_sma[10]_kurtosis,pcm_fftMag_mfcc_sma[11]_max,pcm_fftMag_mfcc_sma[11]_min,pcm_fftMag_mfcc_sma[11]_range,pcm_fftMag_mfcc_sma[11]_maxPos,pcm_fftMag_mfcc_sma[11]_minPos,pcm_fftMag_mfcc_sma[11]_amean,pcm_fftMag_mfcc_sma[11]_linregc1,pcm_fftMag_mfcc_sma[11]_linregc2,pcm_fftMag_mfcc_sma[11]_linregerrQ,pcm_fftMag_mfcc_sma[11]_stddev,pcm_fftMag_mfcc_sma[11]_skewness,pcm_fftMag_mfcc_sma[11]_kurtosis,pcm_fftMag_mfcc_sma[12]_max,pcm_fftMag_mfcc_sma[12]_min,pcm_fftMag_mfcc_sma[12]_range,pcm_fftMag_mfcc_sma[12]_maxPos,pcm_fftMag_mfcc_sma[12]_minPos,pcm_fftMag_mfcc_sma[12]_amean,pcm_fftMag_mfcc_sma[12]_linregc1,pcm_fftMag_mfcc_sma[12]_linregc2,pcm_fftMag_mfcc_sma[12]_linregerrQ,pcm_fftMag_mfcc_sma[12]_stddev,pcm_fftMag_mfcc_sma[12]_skewness,pcm_fftMag_mfcc_sma[12]_kurtosis,pcm_zcr_sma_max,pcm_zcr_sma_min,pcm_zcr_sma_range,pcm_zcr_sma_maxPos,pcm_zcr_sma_minPos,pcm_zcr_sma_amean,pcm_zcr_sma_linregc1,pcm_zcr_sma_linregc2,pcm_zcr_sma_linregerrQ,pcm_zcr_sma_stddev,pcm_zcr_sma_skewness,pcm_zcr_sma_kurtosis,voiceProb_sma_max,voiceProb_sma_min,voiceProb_sma_range,voiceProb_sma_maxPos,voiceProb_sma_minPos,voiceProb_sma_amean,voiceProb_sma_linregc1,voiceProb_sma_linregc2,voiceProb_sma_linregerrQ,voiceProb_sma_stddev,voiceProb_sma_skewness,voiceProb_sma_kurtosis,F0_sma_max,F0_sma_min,F0_sma_range,F0_sma_maxPos,F0_sma_minPos,F0_sma_amean,F0_sma_linregc1,F0_sma_linregc2,F0_sma_linregerrQ,F0_sma_stddev,F0_sma_skewness,F0_sma_kurtosis,pcm_RMSenergy_sma_de_max,pcm_RMSenergy_sma_de_min,pcm_RMSenergy_sma_de_range,pcm_RMSenergy_sma_de_maxPos,pcm_RMSenergy_sma_de_minPos,pcm_RMSenergy_sma_de_amean,pcm_RMSenergy_sma_de_linregc1,pcm_RMSenergy_sma_de_linregc2,pcm_RMSenergy_sma_de_linregerrQ,pcm_RMSenergy_sma_de_stddev,pcm_RMSenergy_sma_de_skewness,pcm_RMSenergy_sma_de_kurtosis,pcm_fftMag_mfcc_sma_de[1]_max,pcm_fftMag_mfcc_sma_de[1]_min,pcm_fftMag_mfcc_sma_de[1]_range,pcm_fftMag_mfcc_sma_de[1]_maxPos,pcm_fftMag_mfcc_sma_de[1]_minPos,pcm_fftMag_mfcc_sma_de[1]_amean,pcm_fftMag_mfcc_sma_de[1]_linregc1,pcm_fftMag_mfcc_sma_de[1]_linregc2,pcm_fftMag_mfcc_sma_de[1]_linregerrQ,pcm_fftMag_mfcc_sma_de[1]_stddev,pcm_fftMag_mfcc_sma_de[1]_skewness,pcm_fftMag_mfcc_sma_de[1]_kurtosis,pcm_fftMag_mfcc_sma_de[2]_max,pcm_fftMag_mfcc_sma_de[2]_min,pcm_fftMag_mfcc_sma_de[2]_range,pcm_fftMag_mfcc_sma_de[2]_maxPos,pcm_fftMag_mfcc_sma_de[2]_minPos,pcm_fftMag_mfcc_sma_de[2]_amean,pcm_fftMag_mfcc_sma_de[2]_linregc1,pcm_fftMag_mfcc_sma_de[2]_linregc2,pcm_fftMag_mfcc_sma_de[2]_linregerrQ,pcm_fftMag_mfcc_sma_de[2]_stddev,pcm_fftMag_mfcc_sma_de[2]_skewness,pcm_fftMag_mfcc_sma_de[2]_kurtosis,pcm_fftMag_mfcc_sma_de[3]_max,pcm_fftMag_mfcc_sma_de[3]_min,pcm_fftMag_mfcc_sma_de[3]_range,pcm_fftMag_mfcc_sma_de[3]_maxPos,pcm_fftMag_mfcc_sma_de[3]_minPos,pcm_fftMag_mfcc_sma_de[3]_amean,pcm_fftMag_mfcc_sma_de[3]_linregc1,pcm_fftMag_mfcc_sma_de[3]_linregc2,pcm_fftMag_mfcc_sma_de[3]_linregerrQ,pcm_fftMag_mfcc_sma_de[3]_stddev,pcm_fftMag_mfcc_sma_de[3]_skewness,pcm_fftMag_mfcc_sma_de[3]_kurtosis,pcm_fftMag_mfcc_sma_de[4]_max,pcm_fftMag_mfcc_sma_de[4]_min,pcm_fftMag_mfcc_sma_de[4]_range,pcm_fftMag_mfcc_sma_de[4]_maxPos,pcm_fftMag_mfcc_sma_de[4]_minPos,pcm_fftMag_mfcc_sma_de[4]_amean,pcm_fftMag_mfcc_sma_de[4]_linregc1,pcm_fftMag_mfcc_sma_de[4]_linregc2,pcm_fftMag_mfcc_sma_de[4]_linregerrQ,pcm_fftMag_mfcc_sma_de[4]_stddev,pcm_fftMag_mfcc_sma_de[4]_skewness,pcm_fftMag_mfcc_sma_de[4]_kurtosis,pcm_fftMag_mfcc_sma_de[5]_max,pcm_fftMag_mfcc_sma_de[5]_min,pcm_fftMag_mfcc_sma_de[5]_range,pcm_fftMag_mfcc_sma_de[5]_maxPos,pcm_fftMag_mfcc_sma_de[5]_minPos,pcm_fftMag_mfcc_sma_de[5]_amean,pcm_fftMag_mfcc_sma_de[5]_linregc1,pcm_fftMag_mfcc_sma_de[5]_linregc2,pcm_fftMag_mfcc_sma_de[5]_linregerrQ,pcm_fftMag_mfcc_sma_de[5]_stddev,pcm_fftMag_mfcc_sma_de[5]_skewness,pcm_fftMag_mfcc_sma_de[5]_kurtosis,pcm_fftMag_mfcc_sma_de[6]_max,pcm_fftMag_mfcc_sma_de[6]_min,pcm_fftMag_mfcc_sma_de[6]_range,pcm_fftMag_mfcc_sma_de[6]_maxPos,pcm_fftMag_mfcc_sma_de[6]_minPos,pcm_fftMag_mfcc_sma_de[6]_amean,pcm_fftMag_mfcc_sma_de[6]_linregc1,pcm_fftMag_mfcc_sma_de[6]_linregc2,pcm_fftMag_mfcc_sma_de[6]_linregerrQ,pcm_fftMag_mfcc_sma_de[6]_stddev,pcm_fftMag_mfcc_sma_de[6]_skewness,pcm_fftMag_mfcc_sma_de[6]_kurtosis,pcm_fftMag_mfcc_sma_de[7]_max,pcm_fftMag_mfcc_sma_de[7]_min,pcm_fftMag_mfcc_sma_de[7]_range,pcm_fftMag_mfcc_sma_de[7]_maxPos,pcm_fftMag_mfcc_sma_de[7]_minPos,pcm_fftMag_mfcc_sma_de[7]_amean,pcm_fftMag_mfcc_sma_de[7]_linregc1,pcm_fftMag_mfcc_sma_de[7]_linregc2,pcm_fftMag_mfcc_sma_de[7]_linregerrQ,pcm_fftMag_mfcc_sma_de[7]_stddev,pcm_fftMag_mfcc_sma_de[7]_skewness,pcm_fftMag_mfcc_sma_de[7]_kurtosis,pcm_fftMag_mfcc_sma_de[8]_max,pcm_fftMag_mfcc_sma_de[8]_min,pcm_fftMag_mfcc_sma_de[8]_range,pcm_fftMag_mfcc_sma_de[8]_maxPos,pcm_fftMag_mfcc_sma_de[8]_minPos,pcm_fftMag_mfcc_sma_de[8]_amean,pcm_fftMag_mfcc_sma_de[8]_linregc1,pcm_fftMag_mfcc_sma_de[8]_linregc2,pcm_fftMag_mfcc_sma_de[8]_linregerrQ,pcm_fftMag_mfcc_sma_de[8]_stddev,pcm_fftMag_mfcc_sma_de[8]_skewness,pcm_fftMag_mfcc_sma_de[8]_kurtosis,pcm_fftMag_mfcc_sma_de[9]_max,pcm_fftMag_mfcc_sma_de[9]_min,pcm_fftMag_mfcc_sma_de[9]_range,pcm_fftMag_mfcc_sma_de[9]_maxPos,pcm_fftMag_mfcc_sma_de[9]_minPos,pcm_fftMag_mfcc_sma_de[9]_amean,pcm_fftMag_mfcc_sma_de[9]_linregc1,pcm_fftMag_mfcc_sma_de[9]_linregc2,pcm_fftMag_mfcc_sma_de[9]_linregerrQ,pcm_fftMag_mfcc_sma_de[9]_stddev,pcm_fftMag_mfcc_sma_de[9]_skewness,pcm_fftMag_mfcc_sma_de[9]_kurtosis,pcm_fftMag_mfcc_sma_de[10]_max,pcm_fftMag_mfcc_sma_de[10]_min,pcm_fftMag_mfcc_sma_de[10]_range,pcm_fftMag_mfcc_sma_de[10]_maxPos,pcm_fftMag_mfcc_sma_de[10]_minPos,pcm_fftMag_mfcc_sma_de[10]_amean,pcm_fftMag_mfcc_sma_de[10]_linregc1,pcm_fftMag_mfcc_sma_de[10]_linregc2,pcm_fftMag_mfcc_sma_de[10]_linregerrQ,pcm_fftMag_mfcc_sma_de[10]_stddev,pcm_fftMag_mfcc_sma_de[10]_skewness,pcm_fftMag_mfcc_sma_de[10]_kurtosis,pcm_fftMag_mfcc_sma_de[11]_max,pcm_fftMag_mfcc_sma_de[11]_min,pcm_fftMag_mfcc_sma_de[11]_range,pcm_fftMag_mfcc_sma_de[11]_maxPos,pcm_fftMag_mfcc_sma_de[11]_minPos,pcm_fftMag_mfcc_sma_de[11]_amean,pcm_fftMag_mfcc_sma_de[11]_linregc1,pcm_fftMag_mfcc_sma_de[11]_linregc2,pcm_fftMag_mfcc_sma_de[11]_linregerrQ,pcm_fftMag_mfcc_sma_de[11]_stddev,pcm_fftMag_mfcc_sma_de[11]_skewness,pcm_fftMag_mfcc_sma_de[11]_kurtosis,pcm_fftMag_mfcc_sma_de[12]_max,pcm_fftMag_mfcc_sma_de[12]_min,pcm_fftMag_mfcc_sma_de[12]_range,pcm_fftMag_mfcc_sma_de[12]_maxPos,pcm_fftMag_mfcc_sma_de[12]_minPos,pcm_fftMag_mfcc_sma_de[12]_amean,pcm_fftMag_mfcc_sma_de[12]_linregc1,pcm_fftMag_mfcc_sma_de[12]_linregc2,pcm_fftMag_mfcc_sma_de[12]_linregerrQ,pcm_fftMag_mfcc_sma_de[12]_stddev,pcm_fftMag_mfcc_sma_de[12]_skewness,pcm_fftMag_mfcc_sma_de[12]_kurtosis,pcm_zcr_sma_de_max,pcm_zcr_sma_de_min,pcm_zcr_sma_de_range,pcm_zcr_sma_de_maxPos,pcm_zcr_sma_de_minPos,pcm_zcr_sma_de_amean,pcm_zcr_sma_de_linregc1,pcm_zcr_sma_de_linregc2,pcm_zcr_sma_de_linregerrQ,pcm_zcr_sma_de_stddev,pcm_zcr_sma_de_skewness,pcm_zcr_sma_de_kurtosis,voiceProb_sma_de_max,voiceProb_sma_de_min,voiceProb_sma_de_range,voiceProb_sma_de_maxPos,voiceProb_sma_de_minPos,voiceProb_sma_de_amean,voiceProb_sma_de_linregc1,voiceProb_sma_de_linregc2,voiceProb_sma_de_linregerrQ,voiceProb_sma_de_stddev,voiceProb_sma_de_skewness,voiceProb_sma_de_kurtosis,F0_sma_de_max,F0_sma_de_min,F0_sma_de_range,F0_sma_de_maxPos,F0_sma_de_minPos,F0_sma_de_amean,F0_sma_de_linregc1,F0_sma_de_linregc2,F0_sma_de_linregerrQ,F0_sma_de_stddev,F0_sma_de_skewness,F0_sma_de_kurtosis" | cat > "${dir}/data/VVC_feats.csv"

cat "${dir}/list/VVC.list" | while read file
do
	cat "${dir}/features/VVC/${file/\.scene/.csv}" >> "${dir}/data/VVC_feats.csv"
done

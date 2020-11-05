#!/bin/bash

# Allows for quick test runs - Set topk to e.g. 20 & midsave to 5
topk=${1:--1}
midsave=${2:-2000}

# 50 Feats, Seed 43
cp ./data/hm_vgattr5050.tsv ./data/HM_img.tsv

python hm.py --seed 43 --model U \
--train train --valid dev_seen --test dev_seen --lr 1e-5 --batchSize 8 --tr bert-large-cased --epochs 5 --tsv \
--num_features 50 --loadpre ./data/uniter-large.pt --num_pos 6 --contrib --midsave $midsave --exp U43 --subtrain --topk $topk

python hm.py --seed 43 --model U \
--train traindev --valid dev_seen --test test_seen,test_unseen --lr 1e-5 --batchSize 8 --tr bert-large-cased --epochs 5 --tsv \
--num_features 50 --loadpre ./data/uniter-large.pt --num_pos 6 --contrib --midsave $midsave --exp U43 --subtrain --topk $topk
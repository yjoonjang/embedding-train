EPOCH=2
LR=1e-5
BATCH_SIZE=4096
MINI_BATCH_SIZE=16
DATE=240919

BATCH_SIZE_DIV8=$((BATCH_SIZE / 8))

export WANDB_PROJECT="KUKE"

# === PT ===
#export WANDB_NAME="KUKE-pt-data=prefinetuning_ko-bs=${BATCH_SIZE_DIV8}-ep=${EPOCH}-lr=${LR}-${DATE}"
#CUDA_VISIBLE_DEVICES=0,1,2,3,4,5,6,7 torchrun --nproc_per_node=8 train.py \
#    --model_name_or_path "intfloat/multilingual-e5-large" \
#    --output_dir "/data/yjoonjang/KUKE/${WANDB_NAME}" \
#    --use_hf_dataset True \
#    --data_dir "nlpai-lab/prefinetuning-embed-full-v2" \
#    --num_epochs $EPOCH \
#    --learning_rate $LR \
#    --per_device_train_batch_size $BATCH_SIZE \
#    --per_device_eval_batch_size $BATCH_SIZE \
#    --mini_batch_size $MINI_BATCH_SIZE \
#    --warmup_steps 100 \
#    --logging_steps 1 \
#    --max_seq_length 512 \
#    --save_strategy epoch \
#    --resume_from_checkpoint False \
#    --test False

# === FT === hf_data False
export WANDB_NAME="KUKE-ft-data=retrieval-bs=${BATCH_SIZE_DIV8}-ep=${EPOCH}-lr=${LR}-${DATE}"
CUDA_VISIBLE_DEVICES=0,1,2,3,4,5,6,7 torchrun --nproc_per_node=8 train.py \
    --model_name_or_path "intfloat/multilingual-e5-large" \
    --output_dir "/data/yjoonjang/KUKE/${WANDB_NAME}" \
    --use_hf_dataset False \
    --data_dir "/data/EMBEDDING/RETRIEVAL/DATA" \
    --num_epochs $EPOCH \
    --learning_rate $LR \
    --per_device_train_batch_size $BATCH_SIZE \
    --per_device_eval_batch_size $BATCH_SIZE \
    --mini_batch_size $MINI_BATCH_SIZE \
    --warmup_ratio 0.1 \
    --logging_steps 2 \
    --max_seq_length 512 \
    --save_strategy epoch \
    --resume_from_checkpoint False \
    --test False
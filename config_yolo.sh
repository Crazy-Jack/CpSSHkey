

echo ""
echo "##############################"
echo "#         Download Code      #"
echo "##############################"
echo ""



cd /workspace
git clone git@github.com:Crazy-Jack/dense_prediction_eval.git
cd /workspace/dense_prediction_eval/YOLOv8-simple/dataset

echo ""
echo "##############################"
echo "#      Download Dataset      #"
echo "##############################"
echo ""

if [ -f "coco_yolo_v8_simple" ] || [ -d "coco" ]; then
    echo "data existed!"
else
    /workspace/b2 file download b2://ffcv-imagenet/coco_yolo_v8_simple.zip coco_yolo_v8_simple.zip
    sudo apt install unzip -y
    unzip coco_yolo_v8_simple.zip
    rm coco_yolo_v8_simple.zip
fi

if [ -d "/workspace/env" ]; then
echo "ENV existed!"
else

# download the ffcv.tar.gz
/workspace/b2 file download b2://ffcv-env/yolov8_env.zip /workspace/yolov8_env.zip

echo ""
echo "##############################"
echo "# Configure Environments #"
echo "##############################"
echo ""

sudo apt-get update && sudo apt-get install ffmpeg libsm6 libxext6 -y


cd /workspace
# Unpack environment into directory `my_env`
unzip yolov8_env.zip
rm yolov8_env.zip


# Activate the environment. This adds `my_env/bin` to your path
conda init && \
source $HOME/.bashrc && conda activate /workspace/env/miniconda3/envs/YOLO




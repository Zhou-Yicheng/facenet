FROM nvcr.io/nvidia/l4t-tensorflow:r32.7.1-tf1.15-py3

WORKDIR /tf/facenet
ENV PYTHONPATH=/tf/facenet/src

COPY requirements.txt .
RUN python3 -m pip install --no-cache-dir --upgrade pip wheel -i
RUN python3 -m pip install --no-cache-dir -r requirements.txt -i
RUN python3 -m pip install --no-cache-dir --prefer-binary notebook
RUN python3 -m pip install --no-cache-dir --prefer-binary opencv-python
# RUN python3 -m pip install --no-cache-dir --upgrade pip wheel -i https://mirrors.cloud.tencent.com/pypi/simple && \
#     python3 -m pip install --no-cache-dir -r requirements.txt -i https://mirrors.cloud.tencent.com/pypi/simple

COPY contributed/face.py .
COPY main.ipynb .
COPY src ./src
COPY lfw_classifier.pkl ./models/
ADD 20180402-114759.tar.gz ./models/
# ADD mtcnnpy.tar.gz ./datasets/lfw
# ADD raw.tar ./datasets/lfw


# docker run --device=/dev/video0 -p 8888:8888 -it yichengzhou/facenet
FROM cschranz/gpu-jupyter:v1.4_cuda-11.2_ubuntu-20.04

USER root

ENV WORK_PATH /workspace

RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/3bf863cc.pub
RUN apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/7fa2af80.pub

RUN apt-get update && \
    apt-get install -y \
			build-essential wget curl python3-pip && \
    apt-get clean && \
		rm -rf /var/lib/apt/lists/* && \
		rm -rf /var/cache/apk/

COPY requirements.txt $WORK_PATH/docker/
ENV PIP_OPTIONS "--no-cache-dir --progress-bar off"
RUN pip3 install -U pip && \
    pip install ${PIP_OPTIONS} -r $WORK_PATH/docker/requirements.txt
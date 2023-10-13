FROM public.ecr.aws/kubeflow-on-aws/notebook-servers/jupyter-pytorch:2.0.0-gpu-py310-cu118-ubuntu20.04-ec2-v1.0

USER root

RUN apt-get update && apt-get install -y sudo ffmpeg
RUN echo "jovyan ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

USER jovyan
RUN wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O ~/miniconda.sh && \
	bash ~/miniconda.sh -b -p $HOME/miniconda && \
	rm ~/miniconda.sh
ENV PATH="/home/jovyan/miniconda/bin:$PATH"

CMD ["sh","-c", "jupyter lab --notebook-dir=/home/jovyan --ip=0.0.0.0 --no-browser --allow-root --port=8888 --NotebookApp.token='' --NotebookApp.password='' --NotebookApp.allow_origin='*' --NotebookApp.base_url=${NB_PREFIX}"]
FROM ghcr.io/davidspek/kubeflownotebook-jupyter-pytorch-full-cuda:latest

USER root
RUN apt-get update && apt-get install -y graphviz git ffmpeg

# Provide password-less sudo to NB_USER
RUN \
	sed -i /etc/sudoers -re 's/^%sudo.*/%sudo ALL=(ALL:ALL) NOPASSWD: ALL/g' && \
	sed -i /etc/sudoers -re 's/^root.*/root ALL=(ALL:ALL) NOPASSWD: ALL/g' && \
	sed -i /etc/sudoers -re 's/^#includedir.*/## **Removed the include directive** ##"/g' && \
	echo "${NB_USER} ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers && \  
	chmod g+w /etc/passwd

USER $NB_UID

CMD bash
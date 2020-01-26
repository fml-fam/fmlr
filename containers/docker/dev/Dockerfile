FROM nvidia/cuda:10.1-devel-ubuntu18.04
ENV MAKE="make -j 4"

RUN echo "deb https://cloud.r-project.org/bin/linux/ubuntu bionic-cran35/" >> /etc/apt/sources.list
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E298A3A825C0D65DFD57CBB651716619E084DAB9

RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get install -y \
    git locales gcc-8 \
    libopenmpi-dev openmpi-common openmpi-bin ssh \
    libopenblas-dev libscalapack-openmpi-dev \
    r-base-dev littler

RUN Rscript -e "install.packages('remotes')"
RUN Rscript -e "install.packages('pbdMPI')"
RUN Rscript -e "install.packages(\"pbdSLAP\", configure.vars=\"EXT_LDFLAGS='-lscalapack-openmpi'\")"
RUN Rscript -e "remotes::install_github('wrathematics/fmlr')"

RUN ["/bin/bash"]

FROM balenalib/raspberrypi4-64-debian
RUN apt-get update && install_packages git build-essential wget
WORKDIR /home/pi/
RUN git clone https://github.com/PastaGringo/sx1302_hal.git
WORKDIR /home/pi/sx1302_hal
RUN make clean all
RUN make install
RUN make install_conf
WORKDIR /home/pi/sx1302_hal/bin
COPY start.sh .
RUN chmod +x reset_lgw.sh start.sh
RUN sed -i -e "s/localhost/helium-miner/g" global_conf.json.sx1250.US915
ENTRYPOINT ["./start.sh"]

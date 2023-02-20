all: clean
	python3 setup.py

clean:
	pkill -9 codis-server codis-proxy codis-dashboard codis-fe || echo 'over'
	rm -f *.conf *.toml *.pyc *.log *.rdb
	rm -rf rootfs

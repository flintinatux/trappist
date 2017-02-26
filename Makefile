DEV_ROCKS = inspect luacheck

play:
	@love src/

build: clean
	cd src && zip -rq ../trappist.love . && cd -

clean:
	rm -f tdn.love

dev:
	@for rock in $(DEV_ROCKS) ; do \
		if ! luarocks list | grep $$rock > /dev/null ; then \
      echo $$rock not found, installing via luarocks... ; \
      luarocks install $$rock ; \
    else \
      echo $$rock already installed, skipping ; \
    fi \
	done;
	@yarn global add luamin

lint:
	@luacheck -q .


DEV_ROCKS = inspect luacheck

play:
	@love src/

build: clean
	cd src && zip -9qry ../dist/trappist.love . && cd -
	cd dist && cp trappist.love trappist.app/Contents/Resources/
	cd dist && zip -9qry trappist-osx.zip trappist.app

clean:
	rm -f dist/trappist.love

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

setup:
	curl -L https://bitbucket.org/rude/love/downloads/love-0.10.2-macosx-x64.zip > dist/love.zip
	unzip -q -d dist dist/love.zip
	mv dist/love.app dist/trappist.app

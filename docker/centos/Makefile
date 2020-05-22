build:
	docker build -t gui-app .

doesnotwork:
	docker run --net=host --env="DISPLAY" --volume="$HOME/.Xauthority:/root/.Xauthority:rw" gui-app

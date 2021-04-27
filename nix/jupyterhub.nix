
    systemd.services.jupyterhub = {
      description = "Jupyter Hub";
      after = [ "network.target" ];
      wantedBy = [ "multi-user.target" ];
      # For some reason, spawnJupyterLab script doesn't work properly if this
      # command is in ExecStart in serviceConfig.
      script = ''
        ${penv}/bin/jupyterhub --Spawner.cmd='${spawnJupyterLab}'
      '';
    };

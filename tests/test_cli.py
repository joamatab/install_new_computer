from typer.testing import CliRunner

from inc import app

runner = CliRunner()


def test_ls():
    result = runner.invoke(app, ["ls"])
    assert result.exit_code == 0
    assert "Available bash scripts:" in result.stdout


def test_ls_recursive():
    result = runner.invoke(app, ["ls", "-r"])
    assert result.exit_code == 0
    assert "Available bash scripts:" in result.stdout


def test_cat_brew():
    result = runner.invoke(app, ["cat", "brew"])
    assert result.exit_code == 0
    assert "brew" in result.stdout.lower()


def test_cat_missing_script():
    result = runner.invoke(app, ["cat", "nonexistent_script_xyz"])
    assert result.exit_code == 0
    assert "not found" in result.stdout


def test_run_dry_run():
    result = runner.invoke(app, ["run", "--dry-run", "brew"])
    assert result.exit_code == 0
    assert "Would execute" in result.stdout


def test_run_missing_script():
    result = runner.invoke(app, ["run", "nonexistent_script_xyz"])
    assert result.exit_code == 0
    assert "not found" in result.stdout


def test_version():
    from inc import __version__

    assert __version__

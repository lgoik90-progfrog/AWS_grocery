import os
import sys
import threading
import webbrowser
from pathlib import Path


def _restart_with_project_venv_if_needed(error: ModuleNotFoundError) -> None:
    """
    If dependencies are missing because a wrong interpreter is used, restart with backend/venv.
    """
    venv_python = Path(__file__).resolve().parent / "venv" / "Scripts" / "python.exe"
    missing_dependency = error.name and error.name.startswith("flask")

    if not missing_dependency:
        raise error

    if not venv_python.exists():
        raise error

    current = Path(sys.executable).resolve()
    target = venv_python.resolve()

    if current == target:
        raise error

    print(f"Missing dependency '{error.name}' with {current}. Restarting with {target}...")
    os.execv(str(target), [str(target), *sys.argv])


try:
    from app import create_app
except ModuleNotFoundError as module_error:
    _restart_with_project_venv_if_needed(module_error)
    raise

app = create_app()

if __name__ == '__main__':
    host = os.getenv("HOST", "0.0.0.0")
    port = int(os.getenv("PORT", "5000"))

    if os.getenv("AUTO_OPEN_BROWSER", "1") == "1":
        threading.Timer(1.5, lambda: webbrowser.open(f"http://localhost:{port}")).start()

    app.run(debug=True, host=host, port=port)

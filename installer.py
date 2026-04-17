import os
import requests
import customtkinter as ctk

ctk.set_appearance_mode("dark")
ctk.set_default_color_theme("green")

URL = "https://raw.githubusercontent.com/Rexilion-Studio/RexLib/main/rexlib.lua"
INSTALL_DIR = os.path.join(os.path.expanduser("~"), ".rexlib")
TARGET_FILE = os.path.join(INSTALL_DIR, "rexlib.lua")

class Installer(ctk.CTk):
    def __init__(self):
        super().__init__()

        self.title("RexLib Installer")
        self.geometry("500x300")
        self.resizable(False, False)

        self.title_label = ctk.CTkLabel(self, text="RexLib Installer", font=("Segoe UI", 24, "bold"))
        self.title_label.pack(pady=20)

        self.desc = ctk.CTkLabel(self, text="Install latest version of RexLib", font=("Segoe UI", 14))
        self.desc.pack(pady=5)

        self.progress = ctk.CTkProgressBar(self, width=350)
        self.progress.set(0)
        self.progress.pack(pady=20)

        self.status = ctk.CTkLabel(self, text="Ready", font=("Segoe UI", 12))
        self.status.pack(pady=5)

        self.button = ctk.CTkButton(self, text="Install / Update", command=self.install)
        self.button.pack(pady=20)

    def update_ui(self, val, text):
        self.progress.set(val)
        self.status.configure(text=text)
        self.update()

    def install(self):
        try:
            self.button.configure(state="disabled")

            self.update_ui(0.2, "Creating directory...")
            os.makedirs(INSTALL_DIR, exist_ok=True)

            self.update_ui(0.4, "Downloading RexLib...")
            r = requests.get(URL)
            r.raise_for_status()

            self.update_ui(0.7, "Installing...")
            with open(TARGET_FILE, "wb") as f:
                f.write(r.content)

            self.update_ui(1.0, "Done ✔")

            self.button.configure(text="Installed", state="disabled")

        except Exception as e:
            self.status.configure(text=f"Error: {e}")
            self.button.configure(state="normal")

app = Installer()
app.mainloop()
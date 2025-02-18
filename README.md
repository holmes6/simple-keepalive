### 📖 **README.md**

```markdown
# 🚀 AccessDrive Startup Script

This guide explains how to set up `AccessDrive.ps1` to run automatically when your computer starts using the Windows Startup Folder.

---

## 🛠️ **1. Prerequisites**

- Windows 10/11  
- PowerShell 5.1+ or PowerShell Core (7.x)  
- Administrative privileges  

---

## 📂 **2. File Structure**

```plaintext
C:\
 └─ scripts\
     ├─ AccessDrive.ps1
     └─ drive_access.log (auto-generated)
```

Ensure `AccessDrive.ps1` is saved at `C:\scripts`.

---

## ⚙️ **3. Script Contents**

The `AccessDrive.ps1` script should look like this:

```powershell
# AccessDrive.ps1
# Continuous access to I: drive with logging.

while ($true) {
    try {
        if (Test-Path "I:\") {
            Get-ChildItem "I:\" | Out-Null
            Add-Content -Path "C:\scripts\drive_access.log" -Value "$(Get-Date) - Successfully accessed I: drive"
        } else {
            Add-Content -Path "C:\scripts\drive_access.log" -Value "$(Get-Date) - I: drive not found"
        }
    } catch {
        Add-Content -Path "C:\scripts\drive_access.log" -Value "$(Get-Date) - Error: $_"
    }

    Start-Sleep -Seconds 60
}
```

This script checks the `I:\` drive every 60 seconds and logs the result to `drive_access.log`.

---

## 🚀 **4. Automatic Startup Setup**

### **Method 1: PowerShell Command (Recommended)**

Open **PowerShell as Administrator** and run this command:

```powershell
$ScriptPath = "C:\scripts\AccessDrive.ps1"
$ShortcutPath = [System.Environment]::GetFolderPath('Startup') + "\AccessDrive.lnk"
$WScriptShell = New-Object -ComObject WScript.Shell
$Shortcut = $WScriptShell.CreateShortcut($ShortcutPath)
$Shortcut.TargetPath = "powershell.exe"
$Shortcut.Arguments = "-WindowStyle Hidden -ExecutionPolicy Bypass -File `"$ScriptPath`""
$Shortcut.WorkingDirectory = "C:\scripts"
$Shortcut.WindowStyle = 7
$Shortcut.Save()
```

---

### **Method 2: Manual Setup**

1. **Open Startup Folder:**  
   - Press `Win + R` → Type `shell:startup` → Press **Enter**.

2. **Create a Shortcut:**  
   - Right-click → **New → Shortcut**.  
   - **Target:**  
     ```plaintext
     powershell.exe -WindowStyle Hidden -ExecutionPolicy Bypass -File "C:\scripts\AccessDrive.ps1"
     ```
   - **Name:** `AccessDrive`.  
   - Right-click the shortcut → **Properties** → **Run:** Select **Minimized**.

---

## ✅ **5. Verification**

- Restart the computer or manually run the shortcut.  
- Open **Task Manager** (`Ctrl+Shift+Esc`) → **Processes** → Look for `powershell.exe`.  
- Check the log:  
  ```powershell
  Get-Content C:\scripts\drive_access.log -Tail 20
  ```

---

## 🛠️ **6. Troubleshooting**

### **Script Doesn't Run?**
- Make sure PowerShell Execution Policy allows the script:  
  ```powershell
  Set-ExecutionPolicy -ExecutionPolicy Bypass -Scope LocalMachine -Force
  ```

### **Drive Not Found?**
- Add a startup delay if the drive is network-based:  
  ```powershell
  Start-Sleep -Seconds 30
  ```

### **Visible Window?**
- Ensure the shortcut is set to **Run: Minimized**.  
- Confirm `-WindowStyle Hidden` is in the command arguments.

---

💾 **Done!** The `AccessDrive.ps1` script now runs at startup and logs its activity to `C:\scripts\drive_access.log`. 🎯
```

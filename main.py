import sys
from PySide2.QtUiTools import QUiLoader
from PySide2.QtWidgets import QApplication
from PySide2.QtCore import QFile, QIODevice

brightness_file = "/sys/class/backlight/intel_backlight/brightness"
max_brightness_file = "/sys/class/backlight/intel_backlight/max_brightness"

if __name__ == "__main__":
    app = QApplication(sys.argv)

    ui_file_name = "mainwindow.ui"
    ui_file = QFile(ui_file_name)
    if not ui_file.open(QIODevice.ReadOnly):
        print("Cannot open {}: {}".format(ui_file_name, ui_file.errorString()))
        sys.exit(-1)
    loader = QUiLoader()
    ui = window = loader.load(ui_file)
    ui_file.close()
    if not window:
        print(loader.errorString())
        sys.exit(-1)
    window.show()

    with open(max_brightness_file) as f: 
        max_brightness = int(f.read())

    def set_brightness(val):
        new_val = int(val / 100 * max_brightness)
        if new_val < 1:
            new_val = 1 # prevent a black screen

        #print("Setting brightness to:", new_val)

        with open(brightness_file, 'w') as f: 
            f.write(str(new_val))


    def get_brightness():
        with open(brightness_file) as f:
            curr = int(f.read())
        #print("current brightness:", curr) 
        return curr / max_brightness * 100 

    def slider_changed():
        val = ui.horizontalSlider.value()
        set_brightness(val)

    ui.horizontalSlider.setValue(get_brightness())
    ui.horizontalSlider.valueChanged.connect(slider_changed)

    sys.exit(app.exec_())
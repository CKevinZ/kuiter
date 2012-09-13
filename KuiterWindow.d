module KuiterWindow;

import std.stdio : p = writeln;

import std.c.process;
/+ For any reason `import std.process` fails, causing a `ld` segfault.
   I use std.c.process instead. +/
import std.datetime;
import std.file;
import std.conv;

import gtk.Main : Kuiter = Main;
import gtk.MainWindow;
import gtk.MessageDialog;
import gtk.VBox;
import gtk.Label;
import gtk.Button;

const string LOG_FILE_PATH = "./kuiter.log";
const char* HALT = "sudo halt";
const char* LOG_OUT = "kill `pgrep xmonad`";

class KuiterWindow : MainWindow {
  this(string title) {
    super(title);
    setDefaults();
    fill();
    showAll();
  }

  private void setDefaults() {
    setResizable(false);
    setPosition(WindowPosition.POS_CENTER);
    setBorderWidth(5);
  }

  private void fill() {
    auto vbox = new VBox(true, 5);
    with(vbox) {
      add(new Label("Will you shutdown or log out?"));
      add(new Button("_Shutdown", &shutdown, true));
      add(new Button("_Log out", &logOut, true));
      add(new Button("_Cancel", &cancel, true));
    }
    add(vbox);
  }

  private void shutdown(Button button) {
    int status = system(HALT);
    if(status != 0)
      log!int(status);
    else exit();
  }

  private void logOut(Button button) {
    int status = system(LOG_OUT);
    if(status != 0)
      log!int(status);
    else exit();
  }

  private void cancel(Button button) {
    Kuiter.exit(0);
  }

  private void exit() {
    Kuiter.exit(0);
  }
}

void log(T)(T logged) {
  LOG_FILE_PATH.append(to!string(Clock.currTime()) ~ ": " ~ to!string(logged) ~ "\n");
}

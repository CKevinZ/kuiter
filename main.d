module main;

import std.file;

import gtk.Main : Kuiter = Main;
import gtk.RcStyle;

import KuiterWindow;

void main(string[] args) {
  Kuiter.init(args);
  scope(exit) Kuiter.run();

  string gtkrc = "./theme/gtkrc";
  if(gtkrc.exists())
    RcStyle.parse(gtkrc);
  else log!string(gtkrc ~ ": not found.");
  new KuiterWindow("Kuiter");
}

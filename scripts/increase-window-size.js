#!/usr/bin/env zx

const WINDOW_SIZE_RATIO = 0.75;

const main = async () => {
  $.verbose = false;

  const displays = JSON.parse(await $`yabai -m query --displays`);
  const displaysObject = displays.reduce(
    (obj, display) => ({ ...obj, [display.index]: display }),
    {}
  );

  const windows = JSON.parse(await $`yabai -m query --windows`);

  const focusedWindow = windows.find((window) => window.focused);
  const { display: displayId } = focusedWindow;
  const display = displaysObject[displayId];

  const resizeWidthDiff = Math.round(
    (display.frame.w * WINDOW_SIZE_RATIO - focusedWindow.frame.w) / 2
  );
  const resizeHeightDiff = Math.round(
    (display.frame.h * WINDOW_SIZE_RATIO - focusedWindow.frame.h) / 2
  );

  await $`yabai -m window ${focusedWindow.id} --resize bottom_right:${resizeWidthDiff}:${resizeHeightDiff}`;
  await $`yabai -m window ${
    focusedWindow.id
  } --resize top_left:${-resizeWidthDiff}:${-resizeHeightDiff}`;
};

main();

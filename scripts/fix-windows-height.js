#!/usr/bin/env zx

const WINDOW_RESIZE_THRESHOLD = 0.9;

const main = async () => {
  $.verbose = false;

  const displays = JSON.parse(await $`yabai -m query --displays`);
  const displaysObject = displays.reduce(
    (obj, display) => ({ ...obj, [display.index]: display }),
    {}
  );

  const windows = JSON.parse(await $`yabai -m query --windows`);
  const windowsToResize = windows.filter((window) => {
    const { display } = window;

    const windowHeight = window.frame.h;
    const displayHeight = displaysObject[display].frame.h;
    const windowHeighCoverage = windowHeight / displayHeight;
    return (
      // make sure it's not a floating window half the screen size
      WINDOW_RESIZE_THRESHOLD < windowHeighCoverage && windowHeighCoverage < 1
    );
  });

  await Promise.all(
    windowsToResize.map(
      (window) =>
        $`yabai -m window ${window.id} --resize top:0:-${window.frame.y}`
    )
  );
};

main();

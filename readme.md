# Chadtech Online 2 Post Composer

Chadtech Online is my personal website. This is the third iteration of that website. I use this electron app to compose the blog posts I put on that website.

How to get going..
```
> git clone https://github.com/Chadtech/Chadtech-Online-2-Post-Composer
> cd ./Chadtech-Online-2-Post-Composer
> npm install
> elm package install --yes
> gulp

.. in a separate terminal

> electron electron-start.js
```


This repo is organized as ..
```
distribution/             -- Your production-ready app
development/              -- Your development app
  index.html
source/                   -- Source files
  app.js                  -- Loads your elm file, and handles ports
  Ports.elm               -- Javascript inter-operation ports
  Main.elm
  Util.elm
  Types/
    Model.elm
    Message.elm
  Styles/
    Main.styl
    field.styl
    p.styl
    a.styl
    field.styl
    section.style
    text-area.styl
    title-bar.styl
  Main/
    Init.elm
    Subscriptions.elm
    Update.elm
    View.elm
gulpFile.js
server.js
electron-start.js
```


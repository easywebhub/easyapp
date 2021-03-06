'use strict';

const debug = /--debug/.test(process.argv);

const fs = require('fs');
const path = require('path');

const electron = require('electron');
const app = electron.app;
const ipcMain = electron.ipcMain;
const browserWindow = electron.BrowserWindow;

// setup relative electron data path
const appDataPath = path.join(process.cwd(), 'data');
app.setPath('appData', appDataPath);
app.setPath('userData', appDataPath);
app.setPath('home', appDataPath);

let mainWindow, webContents;

// setup log
let console = {
    log: () => {
        webContents.send('log', arguments);
    }
};


app.on('window-all-closed', () => {
    if (process.platform !== 'darwin')
        app.quit();
});

app.on('ready', () => {
    let forceQuit = false;

    mainWindow = new browserWindow({
        minWidth:  1020,
        minHeight: 740,
        icon:      __dirname + path.sep + '/favicon.png'
    });
    mainWindow.maximize();
    // if (process.platform === 'linux') {
    //     windowOptions.icon = path.join(__dirname, '/assets/app-icon/png/512.png')
    // }

    mainWindow.on('closed', function () {
        mainWindow = null;
    });

    mainWindow.on('close', function (e) {
        if (process.platform === 'darwin') {
            if (forceQuit) return;
            e.preventDefault();
            mainWindow.hide();
        }
    });

    app.on('before-quit', function (e) {
        forceQuit = true;
    });

    app.on('activate-with-no-open-windows', () => mainWindow.show());
    app.on('activate', () => mainWindow.show());

    mainWindow.loadURL('file://' + __dirname + '/index.html');
    mainWindow.setMenu(null);

    if (debug) {
        mainWindow.webContents.openDevTools();
        mainWindow.maximize();

        if (__dirname.indexOf('.asar') === -1) {
            // auto reload
            ['tag', 'assets/css', 'assets/js', 'index.html'].forEach(dir => {
                fs.watch(__dirname + '/' + dir, {persistent: true, recursive: true}, (event, filename) => {
                    if (filename) {
                        mainWindow.reload();
                    }
                });
            });
        }
    }

    ipcMain.on('toggleDevTools', () => {
        mainWindow.toggleDevTools();
    });

    app.on('window-all-closed', function () {
        if (process.platform !== 'darwin') {
            app.quit();
        }
    });

    webContents = mainWindow.webContents;
});

var API_BASE = window.location.origin;

function apiGet(url) {
    return fetch(API_BASE + url, { credentials: 'include' }).then(r => r.json());
}

function apiPost(url, data) {
    return fetch(API_BASE + url, {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        credentials: 'include',
        body: JSON.stringify(data)
    }).then(r => r.json());
}

function checkLogin() {
    return apiGet('/api/user/current').then(res => {
        if (res.code === 200 && res.data) return res.data;
        return null;
    });
}

function isAdminUser(user) {
    return !!user && (user.role === 1 || user.role === '1' || user.role === 'ADMIN' || user.role === 'admin');
}

function updateAdminLink(user) {
    var adminLink = document.getElementById('adminLink');
    if (adminLink) adminLink.style.display = isAdminUser(user) ? '' : 'none';
}

function logout() {
    apiGet('/api/user/logout').then(() => {
        window.location.href = '/pages/login.html';
    });
}

function showConfirm(msg, callback) {
    var old = document.querySelector('.confirm-overlay');
    if (old) old.remove();
    var overlay = document.createElement('div');
    overlay.className = 'confirm-overlay';
    var dialog = document.createElement('div');
    dialog.className = 'confirm-dialog';
    var p = document.createElement('p');
    p.textContent = msg;
    var wrap = document.createElement('div');
    wrap.className = 'btn-wrap';
    var cancelBtn = document.createElement('button');
    cancelBtn.className = 'btn-cancel';
    cancelBtn.textContent = '取消';
    cancelBtn.onclick = function() { overlay.remove(); if (callback) callback(false); };
    var confirmBtn = document.createElement('button');
    confirmBtn.className = 'btn-confirm';
    confirmBtn.textContent = '确定';
    confirmBtn.onclick = function() { overlay.remove(); if (callback) callback(true); };
    wrap.appendChild(cancelBtn);
    wrap.appendChild(confirmBtn);
    dialog.appendChild(p);
    dialog.appendChild(wrap);
    overlay.appendChild(dialog);
    document.body.appendChild(overlay);
}

function showAlert(msg) {
    var old = document.querySelector('.confirm-overlay');
    if (old) old.remove();
    var overlay = document.createElement('div');
    overlay.className = 'confirm-overlay';
    var dialog = document.createElement('div');
    dialog.className = 'confirm-dialog';
    var p = document.createElement('p');
    p.textContent = msg;
    var wrap = document.createElement('div');
    wrap.className = 'btn-wrap';
    var okBtn = document.createElement('button');
    okBtn.className = 'btn-confirm';
    okBtn.textContent = '确定';
    okBtn.onclick = function() { overlay.remove(); };
    wrap.appendChild(okBtn);
    dialog.appendChild(p);
    dialog.appendChild(wrap);
    overlay.appendChild(dialog);
    document.body.appendChild(overlay);
}

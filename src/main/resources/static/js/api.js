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

function morph(e,n,i){monkeyPatchDomSetAttributeToAllowAtSymbols();let l;let o;let r,d,s,a,u,f,p,c;function assignOptions(e={}){let defaultGetKey=e=>e.getAttribute("key");let noop=()=>{};s=e.updating||noop;a=e.updated||noop;u=e.removing||noop;f=e.removed||noop;p=e.adding||noop;c=e.added||noop;r=e.key||defaultGetKey;d=e.lookahead||false}function patch(e,t){if(differentElementNamesTypesOrKeys(e,t))return swapElements(e,t);let n=false;if(!shouldSkip(s,e,t,(()=>n=true))){e.nodeType===1&&window.Alpine&&window.Alpine.cloneNode(e,t);if(textOrComment(t)){patchNodeValue(e,t);a(e,t)}else{n||patchAttributes(e,t);a(e,t);patchChildren(e,t)}}}function differentElementNamesTypesOrKeys(e,t){return e.nodeType!=t.nodeType||e.nodeName!=t.nodeName||getKey(e)!=getKey(t)}function swapElements(e,t){if(shouldSkip(u,e))return;let n=t.cloneNode(true);if(!shouldSkip(p,n)){e.replaceWith(n);f(e);c(n)}}function patchNodeValue(e,t){let n=t.nodeValue;e.nodeValue!==n&&(e.nodeValue=n)}function patchAttributes(e,t){if(e._x_transitioning)return;if(e._x_isShown&&!t._x_isShown)return;if(!e._x_isShown&&t._x_isShown)return;let n=Array.from(e.attributes);let i=Array.from(t.attributes);for(let i=n.length-1;i>=0;i--){let l=n[i].name;t.hasAttribute(l)||e.removeAttribute(l)}for(let t=i.length-1;t>=0;t--){let n=i[t].name;let l=i[t].value;e.getAttribute(n)!==l&&e.setAttribute(n,l)}}function patchChildren(e,n){e._x_teleport&&(e=e._x_teleport);n._x_teleport&&(n=n._x_teleport);let i=keyToMap(e.children);let l={};let o=getFirstNode(n);let r=getFirstNode(e);while(o){seedingMatchingId(o,r);let s=getKey(o);let a=getKey(r);if(!r){if(!s||!l[s]){if(!shouldSkip(p,o)){let t=o.cloneNode(true);e.appendChild(t);c(t)}o=getNextSibling(n,o);continue}{let t=l[s];e.appendChild(t);r=t}}let isIf=e=>e&&e.nodeType===8&&e.textContent==="[if BLOCK]><![endif]";let isEnd=e=>e&&e.nodeType===8&&e.textContent==="[if ENDBLOCK]><![endif]";if(isIf(o)&&isIf(r)){let i=0;let l=r;while(r){let t=getNextSibling(e,r);if(isIf(t))i++;else if(isEnd(t)&&i>0)i--;else if(isEnd(t)&&i===0){r=t;break}r=t}let d=r;i=0;let s=o;while(o){let e=getNextSibling(n,o);if(isIf(e))i++;else if(isEnd(e)&&i>0)i--;else if(isEnd(e)&&i===0){o=e;break}o=e}let a=o;let u=new t(l,d);let f=new t(s,a);patchChildren(u,f);continue}if(r.nodeType===1&&d&&!r.isEqualNode(o)){let t=getNextSibling(n,o);let i=false;while(!i&&t){if(t.nodeType===1&&r.isEqualNode(t)){i=true;r=addNodeBefore(e,o,r);a=getKey(r)}t=getNextSibling(n,t)}}if(s!==a){if(!s&&a){l[a]=r;r=addNodeBefore(e,o,r);l[a].remove();r=getNextSibling(e,r);o=getNextSibling(n,o);continue}if(s&&!a&&i[s]){r.replaceWith(i[s]);r=i[s]}if(s&&a){let t=i[s];if(!t){l[a]=r;r=addNodeBefore(e,o,r);l[a].remove();r=getNextSibling(e,r);o=getNextSibling(n,o);continue}l[a]=r;r.replaceWith(t);r=t}}let u=r&&getNextSibling(e,r);patch(r,o);o=o&&getNextSibling(n,o);r=u}let s=[];while(r){shouldSkip(u,r)||s.push(r);r=getNextSibling(e,r)}while(s.length){let e=s.shift();e.remove();f(e)}}function getKey(e){return e&&e.nodeType===1&&r(e)}function keyToMap(e){let t={};for(let n of e){let e=getKey(n);e&&(t[e]=n)}return t}function addNodeBefore(e,t,n){if(!shouldSkip(p,t)){let i=t.cloneNode(true);e.insertBefore(i,n);c(i);return i}return t}assignOptions(i);l=e;o=typeof n==="string"?createElement(n):n;if(window.Alpine&&window.Alpine.closestDataStack&&!e._x_dataStack){o._x_dataStack=window.Alpine.closestDataStack(e);o._x_dataStack&&window.Alpine.cloneNode(e,o)}patch(e,o);l=void 0;o=void 0;return e}morph.step=()=>{};morph.log=()=>{};function shouldSkip(e,...t){let n=false;e(...t,(()=>n=true));return n}var e=false;function createElement(e){const t=document.createElement("template");t.innerHTML=e;return t.content.firstElementChild}function textOrComment(e){return e.nodeType===3||e.nodeType===8}var t=class{constructor(e,t){this.startComment=e;this.endComment=t}get children(){let e=[];let t=this.startComment.nextSibling;while(t&&t!==this.endComment){e.push(t);t=t.nextSibling}return e}appendChild(e){this.endComment.before(e)}get firstChild(){let e=this.startComment.nextSibling;if(e!==this.endComment)return e}nextNode(e){let t=e.nextSibling;if(t!==this.endComment)return t}insertBefore(e,t){t.before(e);return e}};function getFirstNode(e){return e.firstChild}function getNextSibling(e,n){let i;i=e instanceof t?e.nextNode(n):n.nextSibling;return i}function monkeyPatchDomSetAttributeToAllowAtSymbols(){if(e)return;e=true;let t=Element.prototype.setAttribute;let n=document.createElement("div");Element.prototype.setAttribute=function newSetAttribute(e,i){if(!e.includes("@"))return t.call(this,e,i);n.innerHTML=`<span ${e}="${i}"></span>`;let l=n.firstElementChild.getAttributeNode(e);n.firstElementChild.removeAttributeNode(l);this.setAttributeNode(l)}}function seedingMatchingId(e,t){let n=t&&t._x_bindings&&t._x_bindings.id;if(n){e.setAttribute("id",n);e.id=n}}function src_default(e){e.morph=morph}var n=src_default;export{n as default,src_default as morph};


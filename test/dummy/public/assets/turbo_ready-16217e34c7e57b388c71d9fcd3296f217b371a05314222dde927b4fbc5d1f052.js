function f(i,a,o={}){let r=new CustomEvent(a,o);i.forEach(t=>t.dispatchEvent(r))}function h(){let i=JSON.parse(this.templateContent.textContent),{id:a,selector:o,receiver:r,method:t,args:c}=i,e=[self];if(o&&(e=Array.from(document.querySelectorAll(o))),r&&(e=e.map(n=>{let s=n,l=r.split(".");for(;l.length>0;)s=s[l.shift()];return s})),t==="dispatchEvent")return f(e,c[0],c[1]||{});if(t.endsWith("="))return e.forEach(n=>n[t.slice(0,-1).trim()]=c[0]);e.forEach(n=>n[t].apply(n,c))}function p(i){i.invoke=h}var u={initialize:p};export{u as default};
//# sourceMappingURL=/assets/turbo_ready.js-b25a46777337e5d9c351240f36123cd7c83bd6601cc98e4d5f8a546699ab3c93.map
//!
;

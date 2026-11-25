/* SIGAP - CRUD local para Productos y Pedidos
   Tecnología: HTML + CSS + JavaScript. Persistencia de demostración con localStorage.
   No sustituye una API, servidor ni base de datos compartida.
*/
(() => {
  "use strict";
  const KEY = "sigap_crud_v1";
  const initial = {
    products: [
      {id:"PROD-001",code:"PROD-001",name:"Panela cuadrada",type:"Panela cuadrada",price:5000,quantity:100,status:"Disponible",description:"Panela tradicional de bloque cuadrado."},
      {id:"PROD-002",code:"PROD-002",name:"Panela redonda",type:"Panela redonda",price:5500,quantity:80,status:"Disponible",description:"Panela tradicional en presentación redonda."},
      {id:"PROD-003",code:"PROD-003",name:"Panela pulverizada",type:"Panela pulverizada",price:8000,quantity:60,status:"Disponible",description:"Panela pulverizada de fácil preparación."},
      {id:"PROD-004",code:"PROD-004",name:"Panela granulada",type:"Panela granulada",price:7500,quantity:75,status:"Disponible",description:"Panela granulada para bebidas y preparaciones."},
      {id:"PROD-005",code:"PROD-005",name:"Panela en cubos",type:"Panela en cubos",price:6500,quantity:50,status:"Disponible",description:"Panela presentada en pequeños cubos."},
      {id:"PROD-006",code:"PROD-006",name:"Panela saborizada",type:"Panela saborizada",price:9000,quantity:40,status:"Disponible",description:"Panela con diferentes sabores y presentaciones."}
    ],
    orders: [
      {id:"PED-001",product:"Panela cuadrada",quantity:100,supplier:"Proveedor principal",date:"2026-12-15",observations:"Pedido de panela para abastecimiento de inventario.",status:"En proceso",progress:70,phase:"Preparación"},
      {id:"PED-002",product:"Panela granulada",quantity:80,supplier:"Proveedor principal",date:"2026-12-20",observations:"Pedido recibido.",status:"Recibido",progress:100,phase:"Producto recibido"}
    ],
    history:[]
  };
  const clone = x => JSON.parse(JSON.stringify(x));
  function load() {
    try { const v=JSON.parse(localStorage.getItem(KEY)); return v && v.products && v.orders ? v : clone(initial); }
    catch (_) { return clone(initial); }
  }
  let db=load();
  function save(){ localStorage.setItem(KEY,JSON.stringify(db)); }
  function esc(v){return String(v ?? "").replace(/[&<>"']/g,c=>({"&":"&amp;","<":"&lt;",">":"&gt;",'"':"&quot;","'":"&#39;"}[c]));}
  function param(){return new URLSearchParams(location.search).get("id");}
  function record(kind,id){return db[kind].find(x=>x.id===id);}
  function log(action,kind,item){db.history.unshift({date:new Date().toLocaleString("es-CO"),action,kind,id:item.id});}
  function form(kind,mode){return document.querySelector(`[data-crud-form="${kind}-${mode}"]`);}
  function values(f){const o={};f.querySelectorAll("[data-field]").forEach(el=>o[el.dataset.field]=el.value.trim());return o;}
  function fill(f,item){if(!item)return;f.querySelectorAll("[data-field]").forEach(el=>{const k=el.dataset.field;if(item[k]!==undefined)el.value=item[k];});}
  function notify(msg){alert(msg);}
  function submit(kind,mode){
    const f=form(kind,mode); if(!f)return;
    const id=param();
    if(mode==="delete"){
      const item=record(kind==="product"?"products":"orders",id);
      if(!item){notify("No se encontró el registro que desea eliminar.");return;}
      if(!confirm(`¿Confirma eliminar ${kind==="product"?"el producto":"el pedido"} ${id}?`))return;
      db[kind==="product"?"products":"orders"]=db[kind==="product"?"products":"orders"].filter(x=>x.id!==id);
      log("Eliminación",kind,item);save();location.href=kind==="product"?"products_read.html":"order_read.html";return;
    }
    const v=values(f);
    if(!f.reportValidity())return;
    if(kind==="product"){
      const duplicate=db.products.some(p=>p.code.toLowerCase()===v.code.toLowerCase() && p.id!==id);
      if(duplicate){notify("Ya existe un producto con ese código.");return;}
      const item={id:mode==="update"?id:(v.code||"PROD-"+Date.now()),...v,price:Number(v.price),quantity:Number(v.quantity)};
      if(mode==="create"){db.products.push(item);log("Registro",kind,item);}
      else {const i=db.products.findIndex(x=>x.id===id);if(i<0){notify("No se encontró el producto.");return;}db.products[i]=item;log("Actualización",kind,item);}
    }else{
      const item={id:mode==="update"?id:"PED-"+String(Date.now()).slice(-8),...v,quantity:Number(v.quantity)};
      const old=mode==="update"?record("orders",id):null;
      if(mode==="update"&&!old){notify("No se encontró el pedido.");return;}
      if(old){Object.assign(item,{status:old.status,progress:old.progress,phase:old.phase});db.orders[db.orders.findIndex(x=>x.id===id)]=item;log("Actualización",kind,item);}
      else {Object.assign(item,{status:"En proceso",progress:0,phase:"Pedido registrado"});db.orders.push(item);log("Registro",kind,item);}
    }
    save();notify(mode==="create"?"Registro guardado correctamente.":"Cambios guardados correctamente.");
    location.href=kind==="product"?"products_read.html":"order_read.html";
  }
  function renderProducts(){
    const host=document.querySelector('[data-crud-list="products"]');if(!host)return;
    const q=(document.querySelector("[data-product-search]")?.value||"").toLowerCase();
    const type=document.querySelector("[data-product-type]")?.value||"Todos los tipos";
    const status=document.querySelector("[data-product-status]")?.value||"Todos los estados";
    const rows=db.products.filter(p=>(`${p.code} ${p.name} ${p.description}`.toLowerCase().includes(q))&&(type==="Todos los tipos"||p.type===type)&&(status==="Todos los estados"||p.status===status));
    host.innerHTML=rows.map(p=>`<article class="producto-card"><div class="producto-imagen">🟫</div><div class="producto-info"><span class="codigo">${esc(p.code)}</span><h3>${esc(p.name)}</h3><p>${esc(p.description)}</p><div class="producto-detalles"><strong>$${Number(p.price).toLocaleString("es-CO")}</strong></div><span class="estado ${p.status==="Disponible"?"activo":""}">${esc(p.status)}</span><p>Cantidad: ${Number(p.quantity)}</p></div><div class="acciones"><a href="products_update.html?id=${encodeURIComponent(p.id)}" class="btn btn-principal">Actualizar</a><a href="products_delete.html?id=${encodeURIComponent(p.id)}" class="btn btn-secundario">Eliminar</a></div></article>`).join("") || "<p>No se encontraron productos.</p>";
  }
  function renderOrders(){
    const host=document.querySelector('[data-crud-list="orders"]');if(!host)return;
    host.innerHTML=db.orders.map(o=>`<article class="pedido-card"><div class="pedido-header"><strong>${esc(o.id)}</strong><span class="estado ${o.status==="Recibido"?"activo":"pendiente"}">${esc(o.status)}</span></div><h3>${esc(o.product)}</h3><p>Cantidad solicitada: ${Number(o.quantity)} unidades</p><div class="progreso"><div class="barra"><div class="barra-progreso" style="width:${Math.max(0,Math.min(100,Number(o.progress)||0))}%"></div></div><span>${Number(o.progress)||0}%</span></div><small>Fase: ${esc(o.phase||"Pedido registrado")}</small><p>Proveedor: ${esc(o.supplier)}</p><p>Fecha estimada: ${esc(o.date)}</p><div class="acciones"><a href="order_update.html?id=${encodeURIComponent(o.id)}" class="btn btn-principal">Actualizar</a><a href="order_delete.html?id=${encodeURIComponent(o.id)}" class="btn btn-secundario">Eliminar</a></div></article>`).join("") || "<p>No hay pedidos registrados.</p>";
  }
  function init(){
    document.querySelectorAll("[data-submit]").forEach(b=>b.addEventListener("click",()=>{const [kind,mode]=b.dataset.submit.split("-");submit(kind,mode);}));
    const pid=param();
    for(const kind of ["product","order"]){
      const collection=kind==="product"?"products":"orders";
      for(const mode of ["update","delete"]){const f=form(kind,mode);if(f){const item=record(collection,pid);if(item)fill(f,item);else if(pid)notify("No se encontró el registro solicitado.");}}
    }
    renderProducts();renderOrders();
    ["[data-product-search]","[data-product-type]","[data-product-status]"].forEach(sel=>document.querySelector(sel)?.addEventListener(sel.includes("search")?"input":"change",renderProducts));
  }
  if(document.readyState==="loading")document.addEventListener("DOMContentLoaded",init);else init();
  // Herramienta opcional de desarrollo: SIGAP.resetDemo() restaura los datos iniciales.
  window.SIGAP={resetDemo(){if(confirm("¿Restaurar los datos de demostración?")){db=clone(initial);save();location.reload();}}};
})();

````markdown
# 🔒 Script Menottes Sécurisé (ESX + ox_inventory + KzAC)

Ce script ajoute un système de menottage réaliste et sécurisé pour **FiveM** avec **ESX** et **ox_inventory**.  
Il inclut une protection anti-cheat **KzAC** : toute tentative de triche (utilisation de triggers sans item, menottage à distance, etc.) entraîne **un kick automatique**.

---

## ✨ Fonctionnalités
- Menotter un joueur proche avec des menottes (`Config.ItemMenottes`)
- Retirer les menottes avec une clé (`Config.ItemCle`)
- Vérification automatique des items via `ox_inventory`
- Vérification de proximité (max 3 mètres)
- Anti-cheat **KzAC** :
  - Kick si tentative de menotter sans menottes
  - Kick si tentative de retirer sans clé
  - Kick si tentative à distance
  - Kick si tentative de démenotter un joueur non menotté
- Gestion propre de l’état menotté même si le joueur crash/déconnecte
- Notifications via **ox_lib**

---

## ⚙️ Dépendances
- [es_extended (ESX)](https://github.com/esx-framework/es_extended)
- [ox_inventory](https://github.com/overextended/ox_inventory)
- [ox_lib](https://github.com/overextended/ox_lib)

---

## 📂 Installation
1. Télécharge le script et place-le dans ton dossier `resources/`
2. Renomme le dossier en `menottes` (ou comme tu veux)
3. Ajoute ceci dans ton `server.cfg` :
   ```cfg
   ensure menottes
````

4. Configure les items dans `ox_inventory` :

   ```lua
   -- shared/items.lua (ou équivalent selon ta config)
   ['menottes'] = {
       label = 'Menottes',
       weight = 200,
       stack = false,
       close = true,
   },
   ['cle_menottes'] = {
       label = 'Clé de menottes',
       weight = 100,
       stack = true,
       close = true,
   }
   ```

   ⚠️ Assure-toi que les noms correspondent à `Config.ItemMenottes` et `Config.ItemCle`.

---

## 🔧 Configuration

Dans `config.lua` :

```lua
Config = {}

Config.ItemMenottes = 'item'
Config.ItemCle = 'item'
```

---

## 🚨 Sécurité (KzAC)

Le script inclut une protection anti-cheat.
Exemples de kick :

* `KzAC : Tentative de triche.`

---

## 👨‍💻 Crédits

* Développement : **\[kazaa]**
* Frameworks : [ESX](https://github.com/esx-framework/es_extended), [ox\_inventory](https://github.com/overextended/ox_inventory), [ox\_lib](https://github.com/overextended/ox_lib)

---

## 📜 Licence

Ce projet est sous licence MIT.
Vous êtes libre de l'utiliser et de le modifier, mais merci de conserver les crédits.

# 📊 Analyseur de Performances Serveur (Server Stats)

Un script Bash robuste pour surveiller et analyser rapidement l'état et les performances d'un serveur Linux. Ce projet a été développé dans le cadre des parcours d'apprentissage pratiques de roadmap.sh.

**Lien du projet original :** [https://roadmap.sh/projects/server-stats](https://roadmap.sh/projects/server-stats)

## 🎯 Objectif 

L'objectif de ce script est de fournir une vue d'ensemble instantanée de la santé d'un serveur. Il est conçu pour être un outil de débogage rapide et efficace, exécutable directement en ligne de commande, sans nécessiter l'installation d'agents de surveillance complexes.

## ✨ Fonctionnalités

Le script `server-stats.sh` analyse le système en temps réel et affiche de manière lisible les métriques suivantes :

**Métriques de base :**
* **Utilisation globale du CPU** (Charge actuelle en pourcentage)
* **Utilisation de la mémoire (RAM)** (Totale, utilisée, libre avec pourcentages)
* **Utilisation de l'espace disque** (Total, utilisé, libre avec pourcentages)
* **Top 5 des processus** consommant le plus de **CPU**
* **Top 5 des processus** consommant le plus de **Mémoire**

**Métriques avancées (Stretch Goals) :**
* Version du système d'exploitation (OS)
* Temps de disponibilité du serveur (Uptime)
* Moyenne de charge (Load Average - 1m, 5m, 15m)
* Utilisateurs actuellement connectés au serveur
* Nombre de tentatives de connexion SSH échouées (sécurité)

## 🛠️ Prérequis et Compatibilité

Ce script est conçu pour être hautement compatible. Il fonctionne sur la majorité des distributions Linux (Fedora, Debian, Ubuntu, CentOS, etc.) en s'appuyant uniquement sur des utilitaires natifs tels que `top`, `free`, `df`, `ps` et `awk`.

## 🚀 Installation et Utilisation

1. **Cloner le dépôt :**
   ```bash
   git clone [https://github.com/badr-abba/server-stats.git](https://github.com/badr-abba/server-stats.git)
   cd server-stats

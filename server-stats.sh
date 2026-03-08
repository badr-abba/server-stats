#!/bin/bash

# Define colors for output formatting
CYAN='\033[0;36m'
GREEN='\033[0;32m'
NC='\033[0m' # No Color

echo -e "${CYAN}=================================================================${NC}"
echo -e "${CYAN}                   SERVER PERFORMANCE STATS                      ${NC}"
echo -e "${CYAN}=================================================================${NC}"

# 1. Total CPU usage
echo -e "\n${GREEN}--- Total CPU Usage ---${NC}"
# Extracting CPU load percentage from top
CPU_LOAD=$(top -bn1 | grep -i '%cpu' | awk '{print $2 + $4}')
echo "Current CPU Load: $CPU_LOAD%"

# 2. Total Memory Usage
echo -e "\n${GREEN}--- Total Memory Usage (RAM) ---${NC}"
free -m | awk 'NR==2{printf "Total: %s MB\nUsed: %s MB (%.2f%%)\nFree: %s MB (%.2f%%)\n", $2, $3, $3*100/$2, $4, $4*100/$2}'

# 3. Total Disk Usage
echo -e "\n${GREEN}--- Total Disk Usage ---${NC}"
# Summarizing total disk usage across all filesystems
df -h --total | awk '/^total/ {printf "Total: %s\nUsed: %s (%s)\nFree: %s\n", $2, $3, $5, $4}'

# 4. Top 5 processes by CPU usage
echo -e "\n${GREEN}--- Top 5 Processes by CPU Usage ---${NC}"
ps -eo pid,user,%cpu,%mem,comm --sort=-%cpu | head -n 6

# 5. Top 5 processes by Memory usage
echo -e "\n${GREEN}--- Top 5 Processes by Memory Usage ---${NC}"
ps -eo pid,user,%cpu,%mem,comm --sort=-%mem | head -n 6

echo -e "\n${CYAN}=================================================================${NC}"
echo -e "${CYAN}                       STRETCH GOALS                             ${NC}"
echo -e "${CYAN}=================================================================${NC}"

# OS Version
echo -e "\n${GREEN}--- OS Version ---${NC}"
if [ -f /etc/os-release ]; then
    grep "PRETTY_NAME" /etc/os-release | cut -d= -f2 | tr -d '"'
else
    uname -snrvm
fi

# Uptime
echo -e "\n${GREEN}--- Uptime ---${NC}"
uptime -p

# Load Average
echo -e "\n${GREEN}--- Load Average ---${NC}"
cat /proc/loadavg | awk '{print $1" (1m), "$2" (5m), "$3" (15m)"}'

# Logged In Users
echo -e "\n${GREEN}--- Logged In Users ---${NC}"
USER_COUNT=$(who | wc -l)
echo "Total Active Sessions: $USER_COUNT"
if [ "$USER_COUNT" -gt 0 ]; then
    echo "Users connected: $(who | awk '{print $1}' | sort | uniq | xargs)"
fi

# Failed Login Attempts
echo -e "\n${GREEN}--- Failed SSH Login Attempts ---${NC}"
# Checking common log locations depending on the distribution
if [ -f /var/log/auth.log ]; then
    # Debian/Ubuntu systems
    sudo grep "Failed password" /var/log/auth.log 2>/dev/null | wc -l || echo "Requires root/sudo privileges to read logs."
elif [ -f /var/log/secure ]; then
    # RHEL/CentOS/Fedora systems
    sudo grep "Failed password" /var/log/secure 2>/dev/null | wc -l || echo "Requires root/sudo privileges to read logs."
else
    # Fallback to systemd journal
    sudo journalctl _SYSTEMD_UNIT=sshd.service 2>/dev/null | grep "Failed password" | wc -l || echo "Requires root/sudo privileges to read logs."
fi

echo -e "\n"

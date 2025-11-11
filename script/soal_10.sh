
# ELROS - LOAD BALANCER (SOAL 10)


cat << 'ELROS_SCRIPT'
echo "=== Setting up Elros - Load Balancer ==="

# 1. Install Nginx
apt-get update
apt-get install -y nginx

# 2. === SOAL 10: Configure Load Balancer ===
cat > /etc/nginx/sites-available/load-balancer << 'EOF'
# Upstream backend - Kesatria Numenor
upstream kesatria_numenor {
    # Round Robin algorithm (default)
    server elendil.K11.com:8001;
    server isildur.K11.com:8002;
    server anarion.K11.com:8003;
}

server {
    listen 80;
    server_name elros.K11.com;

    location / {
        proxy_pass http://kesatria_numenor;
        
        # Proxy headers
        proxy_set_header Host $host;
        proxy_set_header X-Real-IP $remote_addr;
        proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        proxy_set_header X-Forwarded-Proto $scheme;
        
        # Proxy timeouts
        proxy_connect_timeout 60s;
        proxy_send_timeout 60s;
        proxy_read_timeout 60s;
    }

    # Health check endpoint
    location /health {
        access_log off;
        return 200 "Elros Load Balancer is healthy\n";
        add_header Content-Type text/plain;
    }

    access_log /var/log/nginx/elros_access.log;
    error_log /var/log/nginx/elros_error.log;
}
EOF

# 3. Enable Site
ln -sf /etc/nginx/sites-available/load-balancer /etc/nginx/sites-enabled/
rm -f /etc/nginx/sites-enabled/default

# 4. Test & Restart
nginx -t
service nginx restart

echo ""
echo "=== Elros Load Balancer Setup Complete! ==="
echo "Domain: elros.K11.com"
echo "Algorithm: Round Robin"
echo "Backends:"
echo "  - elendil.K11.com:8001"
echo "  - isildur.K11.com:8002"
echo "  - anarion.K11.com:8003"
echo ""
echo "Test: curl http://elros.K11.com"
ELROS_SCRIPT


# Di Elros:
service nginx status
nginx -T | grep -A 5 upstream
curl http://localhost/health
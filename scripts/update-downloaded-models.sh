#!/bin/bash

echo "Updating previously downloaded models"
ollama list | awk 'NR>1 {print $1}' | xargs -I {} ollama pull {}
echo "Models updated"

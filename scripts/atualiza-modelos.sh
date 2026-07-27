#!/bin/bash

echo "Atualizando modelos previamente baixados"
ollama list | awk 'NR>1 {print $1}' | xargs -I {} ollama pull {}
echo "Modelos atualizados"

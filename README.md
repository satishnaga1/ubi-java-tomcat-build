# ubi-java-tomcat-build
build images with ubi-java-tomcat
- name: Generate Workflow Diagram
  run: |
    echo "# Docker Build Workflow" >> $GITHUB_STEP_SUMMARY
    echo "" >> $GITHUB_STEP_SUMMARY
    echo "```mermaid" >> $GITHUB_STEP_SUMMARY
    echo "flowchart LR" >> $GITHUB_STEP_SUMMARY
    echo "A[Trigger Workflow]" >> $GITHUB_STEP_SUMMARY
    echo "A --> B[Checkout Code]" >> $GITHUB_STEP_SUMMARY
    echo "B --> C[Docker Login]" >> $GITHUB_STEP_SUMMARY
    echo "C --> D[Build Docker Image]" >> $GITHUB_STEP_SUMMARY
    echo "D --> E[Tag Image]" >> $GITHUB_STEP_SUMMARY
    echo "E --> F[Push Image]" >> $GITHUB_STEP_SUMMARY
    echo "F --> G[Docker Hub]" >> $GITHUB_STEP_SUMMARY
    echo "```" >> $GITHUB_STEP_SUMMARY

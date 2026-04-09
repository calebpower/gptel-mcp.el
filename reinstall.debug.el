;;; reinstall.debug.el --- Clean reinstall gptel-mcp and mcp -*- lexical-binding: t -*-

(let* ((packages '((gptel-mcp . "https://github.com/calebpower/gptel-mcp.el")
                   (mcp . "https://github.com/lizqwerscott/mcp.el")))
       ;; We delete in order: gptel-mcp (dependent) then mcp (dependency)
       (delete-order '(gptel-mcp mcp))
       ;; We install in order: mcp then gptel-mcp
       (install-order '(mcp gptel-mcp)))

  ;; --- STEP 1: DELETION ---
  (dolist (pkg-name delete-order)
    (let ((pkg-dir (expand-file-name (format "elpa/%s" pkg-name) user-emacs-directory)))
      
      ;; Uninstall metadata
      (when (package-installed-p pkg-name)
        (condition-case nil
            (let ((pkg-desc (cadr (assq pkg-name package-alist))))
              (when pkg-desc (package-delete pkg-desc)))
          (error (message "package-delete failed for %s, skipping to manual..." pkg-name))))

      ;; Nuclear file deletion
      (when (file-exists-p pkg-dir)
        (delete-directory pkg-dir t)
        (message "Deleted physical directory for: %s" pkg-name))))

  ;; --- STEP 2: INSTALLATION ---
  ;; Install mcp first, then gptel-mcp (with the specific bugfix branch)
  (dolist (pkg-name install-order)
    (cond
     ((eq pkg-name 'gptel-mcp)
      (package-vc-install 
       '(gptel-mcp :url "https://github.com/calebpower/gptel-mcp.el" 
                   :branch "main")))
     ((eq pkg-name 'mcp)
      (package-vc-install 
       '(mcp :url "https://github.com/lizqwerscott/mcp.el")))))

  (message "Clean reinstall of mcp and gptel-mcp complete!"))

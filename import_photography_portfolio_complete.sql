-- Import Scraped Template: photography_portfolio_complete
-- Generated: 2026-01-19 21:08:33
-- Source: https://www.freepik.com
-- Sections: 0
--
-- Run this script to import the template into PostgreSQL:
-- psql -d website_builder < photography_portfolio_complete.sql
--


BEGIN;

-- Insert the template
INSERT INTO templates (template_name, description, project_name, created_date)
VALUES (
    'photography_portfolio_complete',
    'Imported from https://www.freepik.com - Metadata: {"url": "https://www.freepik.com", "scraped_date": "2026-01-19T21:08:33.856409", "forms": [], "social_links": [], "seo_data": {"title": "Access denied", "description": "", "keywords": "", "og": {"title": "", "description": "", "image": "", "url": ""}, "twitter": {"card": "", "title": "", "description": "", "image": ""}, "favicon": "https://fps.cdnpk.net/favicons/favicon.ico", "canonical": "", "lang": "es"}, "custom_fonts": ["https://fps.cdnpk.net/static/inter-regular.woff2", "https://fps.cdnpk.net/static/inter-semibold.woff2", "https://fps.cdnpk.net/static/inter-bold.woff2", "https://fps.cdnpk.net/static/degular-regular.woff2", "https://fps.cdnpk.net/static/degular-semibold.woff2"], "advanced_css": {"hoverEffects": [{"selector": "._1286nb14or, ._1286nb14os:hover, ._1286nb14ot:focus, ._1286nb14ou:disabled", "css": "border-color: currentcolor;"}, {"selector": "._1286nb14ov, ._1286nb14ow:hover, ._1286nb14ox:focus, ._1286nb14oy:disabled", "css": "border-color: transparent;"}, {"selector": "._1286nb14oz, ._1286nb14p0:hover, ._1286nb14p1:focus, ._1286nb14p2:disabled", "css": "border-color: inherit;"}, {"selector": "._1286nb14p3, ._1286nb14p4:hover, ._1286nb14p5:focus, ._1286nb14p6:disabled", "css": "border-color: rgba(var(--_otnfkqd),var(--_otnfkq28));"}, {"selector": "._1286nb14p7, ._1286nb14p8:hover, ._1286nb14p9:focus, ._1286nb14pa:disabled", "css": "border-color: rgba(var(--_otnfkqd),var(--_otnfkq29));"}, {"selector": "._1286nb14pb, ._1286nb14pc:hover, ._1286nb14pd:focus, ._1286nb14pe:disabled", "css": "border-color: rgba(var(--_otnfkqd),var(--_otnfkq2a));"}, {"selector": "._1286nb14pf, ._1286nb14pg:hover, ._1286nb14ph:focus, ._1286nb14pi:disabled", "css": "border-color: rgba(var(--_otnfkqd),var(--_otnfkq2b));"}, {"selector": "._1286nb14pj, ._1286nb14pk:hover, ._1286nb14pl:focus, ._1286nb14pm:disabled", "css": "border-color: rgba(var(--_otnfkqd),var(--_otnfkq2c));"}, {"selector": "._1286nb14pn, ._1286nb14po:hover, ._1286nb14pp:focus, ._1286nb14pq:disabled", "css": "border-color: rgba(var(--_otnfkqd),var(--_otnfkq2d));"}, {"selector": "._1286nb14pr, ._1286nb14ps:hover, ._1286nb14pt:focus, ._1286nb14pu:disabled", "css": "border-color: rgba(var(--_otnfkqd),var(--_otnfkq2e));"}, {"selector": "._1286nb14pv, ._1286nb14pw:hover, ._1286nb14px:focus, ._1286nb14py:disabled", "css": "border-color: rgba(var(--_otnfkqd),var(--_otnfkq2f));"}, {"selector": "._1286nb14pz, ._1286nb14q0:hover, ._1286nb14q1:focus, ._1286nb14q2:disabled", "css": "border-color: rgba(var(--_otnfkqd),var(--_otnfkq2g));"}, {"selector": "._1286nb14q3, ._1286nb14q4:hover, ._1286nb14q5:focus, ._1286nb14q6:disabled", "css": "border-color: rgba(var(--_otnfkqd),var(--_otnfkq2h));"}, {"selector": "._1286nb14q7, ._1286nb14q8:hover, ._1286nb14q9:focus, ._1286nb14qa:disabled", "css": "border-color: rgb(var(--_otnfkqd));"}, {"selector": "._1286nb14qb, ._1286nb14qc:hover, ._1286nb14qd:focus, ._1286nb14qe:disabled", "css": "border-color: rgba(var(--_otnfkqe),var(--_otnfkq28));"}, {"selector": "._1286nb14qf, ._1286nb14qg:hover, ._1286nb14qh:focus, ._1286nb14qi:disabled", "css": "border-color: rgba(var(--_otnfkqe),var(--_otnfkq29));"}, {"selector": "._1286nb14qj, ._1286nb14qk:hover, ._1286nb14ql:focus, ._1286nb14qm:disabled", "css": "border-color: rgba(var(--_otnfkqe),var(--_otnfkq2a));"}, {"selector": "._1286nb14qn, ._1286nb14qo:hover, ._1286nb14qp:focus, ._1286nb14qq:disabled", "css": "border-color: rgba(var(--_otnfkqe),var(--_otnfkq2b));"}, {"selector": "._1286nb14qr, ._1286nb14qs:hover, ._1286nb14qt:focus, ._1286nb14qu:disabled", "css": "border-color: rgba(var(--_otnfkqe),var(--_otnfkq2c));"}, {"selector": "._1286nb14qv, ._1286nb14qw:hover, ._1286nb14qx:focus, ._1286nb14qy:disabled", "css": "border-color: rgba(var(--_otnfkqe),var(--_otnfkq2d));"}, {"selector": "._1286nb14qz, ._1286nb14r0:hover, ._1286nb14r1:focus, ._1286nb14r2:disabled", "css": "border-color: rgba(var(--_otnfkqe),var(--_otnfkq2e));"}, {"selector": "._1286nb14r3, ._1286nb14r4:hover, ._1286nb14r5:focus, ._1286nb14r6:disabled", "css": "border-color: rgba(var(--_otnfkqe),var(--_otnfkq2f));"}, {"selector": "._1286nb14r7, ._1286nb14r8:hover, ._1286nb14r9:focus, ._1286nb14ra:disabled", "css": "border-color: rgba(var(--_otnfkqe),var(--_otnfkq2g));"}, {"selector": "._1286nb14rb, ._1286nb14rc:hover, ._1286nb14rd:focus, ._1286nb14re:disabled", "css": "border-color: rgba(var(--_otnfkqe),var(--_otnfkq2h));"}, {"selector": "._1286nb14rf, ._1286nb14rg:hover, ._1286nb14rh:focus, ._1286nb14ri:disabled", "css": "border-color: rgb(var(--_otnfkqe));"}, {"selector": "._1286nb14rj, ._1286nb14rk:hover, ._1286nb14rl:focus, ._1286nb14rm:disabled", "css": "border-color: rgb(var(--_otnfkqf));"}, {"selector": "._1286nb14rn, ._1286nb14ro:hover, ._1286nb14rp:focus, ._1286nb14rq:disabled", "css": "border-color: rgba(var(--_otnfkqg),var(--_otnfkq28));"}, {"selector": "._1286nb14rr, ._1286nb14rs:hover, ._1286nb14rt:focus, ._1286nb14ru:disabled", "css": "border-color: rgba(var(',  -- Limit to 5000 chars
    'Photography Portfolio Complete',
    '2026-01-19 21:08:33'
);


-- Get the template ID
DO $$
DECLARE
    template_id_var integer;
BEGIN
    SELECT id INTO template_id_var FROM templates WHERE template_name = 'photography_portfolio_complete';

END $$;

COMMIT;


-- Template import complete!
-- Template name: photography_portfolio_complete
-- Total sections: 0
--
-- To verify the import:
-- SELECT * FROM templates WHERE template_name = 'photography_portfolio_complete';
-- SELECT COUNT(*) FROM sections WHERE template_id = (SELECT id FROM templates WHERE template_name = 'photography_portfolio_complete');

-- Update sections with BYTEA image data

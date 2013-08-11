package com.jspxcms.core.domaindsl;

import static com.mysema.query.types.PathMetadataFactory.*;

import com.jspxcms.core.domain.RoleSite;
import com.mysema.query.types.path.*;

import com.mysema.query.types.PathMetadata;

import com.mysema.query.types.Path;
import com.mysema.query.types.path.PathInits;


/**
 * QRoleSite is a Querydsl query type for RoleSite
 */

public class QRoleSite extends EntityPathBase<RoleSite> {

    private static final long serialVersionUID = 833478011;

    private static final PathInits INITS = PathInits.DIRECT;

    public static final QRoleSite roleSite = new QRoleSite("roleSite");

    public final BooleanPath allInfo = createBoolean("allInfo");

    public final BooleanPath allNode = createBoolean("allNode");

    public final NumberPath<Integer> id = createNumber("id", Integer.class);

    public final NumberPath<Integer> rightType = createNumber("rightType", Integer.class);

    public final QRole role;

    public final QSite site;

    public QRoleSite(String variable) {
        this(RoleSite.class, forVariable(variable), INITS);
    }

    @SuppressWarnings("all")
    public QRoleSite(Path<? extends RoleSite> path) {
        this((Class)path.getType(), path.getMetadata(), path.getMetadata().isRoot() ? INITS : PathInits.DEFAULT);
    }

    public QRoleSite(PathMetadata<?> metadata) {
        this(metadata, metadata.isRoot() ? INITS : PathInits.DEFAULT);
    }

    public QRoleSite(PathMetadata<?> metadata, PathInits inits) {
        this(RoleSite.class, metadata, inits);
    }

    public QRoleSite(Class<? extends RoleSite> type, PathMetadata<?> metadata, PathInits inits) {
        super(type, metadata, inits);
        this.role = inits.isInitialized("role") ? new QRole(forProperty("role"), inits.get("role")) : null;
        this.site = inits.isInitialized("site") ? new QSite(forProperty("site"), inits.get("site")) : null;
    }

}

